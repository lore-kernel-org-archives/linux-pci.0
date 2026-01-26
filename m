Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E82FB962
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429040; cv=none; b=sPROAW+S3jeSbkrrl1/H/57MgBMfMK0pRM6ngYKD2/5NmhDWjvJDN8bKzx7J3QBsLi1xQsUvw6z4VSfORbDQmgKP0l3Y4OHkHXhIa16BRycpUHPq5b+oaXj71DuWBuq0X3IpSUkTaRNk5QWmRCb1eAL+qiHVTzJna+09wXJHayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429040; c=relaxed/simple;
	bh=DQZiZqgNqxMzqhVSfR6kr06o7Za2CSOrc5hRnE7QVPk=;
	h=From:Date:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZvQ5xUZifb2FV69CDdD/1L+pCh/TRQGRbFdwtEyvaI9WquvWaVX4Wy6El4QQ+WKuuHe3kJMybY0J3JPq8hZbGUI9xiz49Dw5tVIi8z42XoJHLscq825IA2I1Ko4eaHOkzB2AXcUHKO8WRdMlJXRUX56Eu2oiawcGskSRDLKWWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdxzna+G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdxzna+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769429039; x=1800965039;
  h=from:date:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=DQZiZqgNqxMzqhVSfR6kr06o7Za2CSOrc5hRnE7QVPk=;
  b=Tdxzna+GnWBlyQf/IVOKlbqRZaDRjhBhp+XN3U+XBgHjAKQY2g06awBt
   j2kOQOPRc4Ph0t7XOp4K3wP1J1/bzHmIpCjKZstXd5dMhFaVAptRAx9Zt
   1mwTh1oWIoUESPJFa9Y+sqAImipf4NfvOlgupGpJQtBlCzaw3aZiZ3xTM
   TKyriLzXzX2uBxkUPYkz42NYBDiLRW1CMPBTVzPtrk6ktudsHAjj8KQ57
   bkuqomiPBuQgapxZmy9UmRTNifgB2ApNMHjorBPG46qlesXnaTc7UIKfg
   CitGtBz4lHOQeAnUE+aP+x3nP2A0MuSPsryb4O8LxPdz/PmLL2AF98YXv
   A==;
X-CSE-ConnectionGUID: 3HkyvmcaTYu1im9FGt7vDw==
X-CSE-MsgGUID: Aa1DiI7sTaGI+rqBU2jgIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="88185209"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="88185209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 04:03:58 -0800
X-CSE-ConnectionGUID: olzbnZW8QEya+6FUa3DyBQ==
X-CSE-MsgGUID: QEJmcmkySk6mEqV05Rf59A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="206785285"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.150])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 04:03:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Jan 2026 14:03:52 +0200 (EET)
To: bugzilla-daemon@kernel.org, 
    =?ISO-8859-15?Q?Malte_Schr=F6der?= <malte+lkml@tnxip.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [Bug 220775] snd_ctxfi fails init since 6.18-rc1
In-Reply-To: <bug-220775-228660-pG3cpJLOFZ@https.bugzilla.kernel.org/>
Message-ID: <e0e34d7a-8919-f3f9-1136-23e6e9f7b203@linux.intel.com>
References: <bug-220775-228660@https.bugzilla.kernel.org/> <bug-220775-228660-pG3cpJLOFZ@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 26 Jan 2026, bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=220775
> 
> --- Comment #27 from Malte (malte+kbz@tnxip.de) ---
> Did this patch make it into 6.19? I just tried -rc7 and the issue is still
> there.

Unfortunately, it's still not applied:

https://patchwork.kernel.org/project/linux-pci/list/?series=1035150

(I also checked pci/resource branch and it doesn't appear there).

The fixes used to be in a separate series but I've so many dependencies 
between my pending work I had to put them into that larger series (in 
hopes that it would have all gotten applied in this cycle).

The regression fixes (this and some ppc (IIRC) regression) are in the 
first 5 commits. I'm not sure if taking the entire series this late is 
a good idea even if the rest of the series should be most no functional 
changes in preparation to some work not yet submitted.


-- 
 i.

