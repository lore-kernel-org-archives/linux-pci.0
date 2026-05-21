Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE073C7DEB;
	Thu, 21 May 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365101; cv=none; b=HGjiSPyUe6VDVtWhVbOquYvT6Z6aOxCwLpmsMFsdNSU4eSucO5iTpOdnRzGlSQHWKvnSWi8JtFirIsONtudwRZDwORLlZrZxACUbgSnG9vOkud983o9LTBXJaC0solfwA/SHms9IBYZpccULyBTUYHLzHT6sANIgwIwOpiIOcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365101; c=relaxed/simple;
	bh=pSbju6AMDfFexxdHSuz4INZ3g5g8DGo996y/6btELNQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=il23uHARhC16Lfmvsku9yjYyUX1uil3eHpZwsaudgky0rgvrbOJ9ceLKbCg2XR/sro7Wb07glFlf2k7K5E8sp0xb3BcZ1zY8xctyuxEFfWSkegPxch/WgN5HuBPjkYPpnEqlz6/m76WYt6V0oo/NOMp3/v8vk+8EB5UMGjCylHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtncKoKp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtncKoKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779365100; x=1810901100;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pSbju6AMDfFexxdHSuz4INZ3g5g8DGo996y/6btELNQ=;
  b=DtncKoKpsbqeG7p9ogMA2+/Nq3Q1GDfcRzfbTgyxLfruI/I/mKv9FTAD
   6kHWinawlqaWGa9elVzB7d7s9V7Im8VF0AovxJ9JgnjY/QOniuf8/v28w
   Rso6wrw9YaGOh/sVZUGGDpsRraGb9eUJu3lt0aiv9R6ugI4yyQMDG4nnD
   gcJE2YTo7Zar8aatPP1uEIqSQbDexZVYakvkSyd2VN7pYaXHvSFfq5TVi
   7UMWHbfPqaz/fqQ/+ezHfNB/KS8fC5BObpUOMf6nteIuwS5QKz3bnLT73
   fOCFpsi9MHL87oJhaNJuZuj6NC0fTBCMWXE3e/yqMzzBcKYnjh9iWepxK
   A==;
X-CSE-ConnectionGUID: bBGTjILkTxiXlSXNbudsmA==
X-CSE-MsgGUID: uf9OrjzWRU+N264GrNltog==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79429618"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="79429618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:04:59 -0700
X-CSE-ConnectionGUID: nXNSmtBoQfmqxMTUD1CuDA==
X-CSE-MsgGUID: XusB+TvJRrKTt5A1EXfAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="239500027"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.98])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:04:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 May 2026 15:04:53 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
cc: Gianfranco Dutka <gianfranco.dutka@arista.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
In-Reply-To: <20260521115906.GC647881@rocinante>
Message-ID: <e47086a4-43ea-997d-e49f-356cc21d22e8@linux.intel.com>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com> <376c679c-8637-d19a-48d1-165d8f2fc2f0@linux.intel.com> <20260521115906.GC647881@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2063069980-1779365093=:1175"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2063069980-1779365093=:1175
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 May 2026, Krzysztof Wilczy=F1ski wrote:

> > To me it looks more like pci_remove_resource_files() is expected to be=
=20
> > entered only once.
> >=20
> > If this change is accepted, the 2nd entry is "silently" allowed whereas=
=20
> > better course of action would feel to catch that in=20
> > pci_remove_resource_files() with:
> >=20
> > =09if (WARN_ON_ONCE(something))
> > =09=09return;
> >=20
> > That way, developers may become aware the code has some lifetime issue.
> >=20
> > (I'm not strictly against your change but I think it would be much bett=
er=20
> > to have sane lifetimes and catch offenders.)
>=20
> The upcoming sysfs changes would remove pci_remove_resource_files()
> completely, so there would not be anything needed to be done here,
> hopefully.

Yeah, I should have looked at that branch first instead of checking just=20
code in mainline.

--=20
 i.

--8323328-2063069980-1779365093=:1175--
