Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93E332919;
	Wed, 15 Apr 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244808; cv=none; b=gqJJqze45jQtOp4MKd1mfvIZ/GIM/hvtB7V91Ztvoh4WNx7KxnulMJQiMyIylY3NXvCqxGrvL7+dMZgepif1kxttv28ZCX6gzCdEkokJJfEvqyrqy7BbHK3UcRIKDWbhLTdJ3ZniYjkJMVW3xMECAONhe7imsKfJBME/116IipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244808; c=relaxed/simple;
	bh=57UoY7yZS9MyAf+dMATtwydTkgWI00D69hwDa2/mVzY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=At/xagWLTxGD8I4ui4TQqotFcG3ZoSIIftEB4bnIM+pQkG8q+bBnhMhkxwX1TnoSAwbFmIemFbPFVEm/e1XR+SBAaMhT2uwxsiI71+tM1Kq8g2YErHf0ixW4fZNnUzwCaMGxrzcK8eKp7NngnVZ329307deqYqshPI7XEAFNnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdimU/eq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdimU/eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776244806; x=1807780806;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=57UoY7yZS9MyAf+dMATtwydTkgWI00D69hwDa2/mVzY=;
  b=EdimU/eq819X3KDpOy/uqSx0AqW1LEEsxQRG923zrSDmhPLxhc0G/gCC
   XNzS41TEKqYEgvs1z4dIrcv42uC+8Dc1GP4BMyavV+uyE2vqqxwB0CvHd
   0hap/CfwdW91GOtblmTKwDX50WsStyWFusC7OBSmvpJQN+eUqk9jQvQBe
   UNz+jgZ257sFaKyjdKx6SosOYidZasmJUxBFayXQr2zAlc7rHmymcC22h
   fJSbVsVrbNRdQgowVAwh4eFYukYo036hfcgQFBd4WHwmVBRkbRCLuSqH7
   f/saHuIJ+DE26YtxjI2MRqfYZqEvcnMDMRCMR4A4GteSs4AeRIa1wANow
   Q==;
X-CSE-ConnectionGUID: tCBmRE49SmKpffqwdOL4Iw==
X-CSE-MsgGUID: L0UFkCwRT5iDng5k/UUMWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77122613"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77122613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:20:05 -0700
X-CSE-ConnectionGUID: UQA5uWU7SeSLyuXYNXJFcw==
X-CSE-MsgGUID: TH8qk+1iRQ6CjII5MJQLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227184557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:20:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Apr 2026 12:19:53 +0300 (EEST)
To: Rio Liu <rio@r26.me>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [REGRESSION] amdgpu fails to load eGPU after 6.19
In-Reply-To: <j-oL8G7jik8a-PYnIVU4kE-w4HJaq9pNshpbPC5zphvGa0SIno_vpSq1zEcBUVDx6hSMvbV1eAIcIO7C8jtMv0GTG7UfvWVZaEzabnQ-6YY=@r26.me>
Message-ID: <3bdf3453-8052-3626-f877-c769b88ee0c0@linux.intel.com>
References: <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me> <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
 <j-oL8G7jik8a-PYnIVU4kE-w4HJaq9pNshpbPC5zphvGa0SIno_vpSq1zEcBUVDx6hSMvbV1eAIcIO7C8jtMv0GTG7UfvWVZaEzabnQ-6YY=@r26.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Apr 2026, Rio Liu wrote:

> Hi Ilpo,
> 
> > This snippet only contains collateral damage and does not show where the
> > problem originates from. Please provide a full dmesg instead with
> > dyndbg="file drivers/pci/*.c +p" on the kernel command line.
> >
> > Preferrably test with the latest code + fixes that are in pci/resources
> > branch (you can just take all changes from there) and get the logs from
> > there. I wouldn't be surprised if your problem is already addressed by
> > those fixes but we'll see.
> 
> Thanks a lot for the help! I tested on pci/resources
> 8cb081667377709f4924ab6b3a88a0d7a761fe91 "PCI: Fix alignment calculation for
> resource size larger than align", and the eGPU is now loading! There are some
> messages in dmesg showing "can't assign; no space" and "failed to assign", but I
> don't see any functional impact from it. Including the dmesg anyways in case
> there's anything important: https://pastebin.com/n5hhtkz0.

Hi,

Thanks for testing.

Most of the assignment failures occur for io resources. It tends to be 
that in large systems of today, hotplug reservation consumes all io space 
for things that don't need any. Usually, the io resource assignment 
failures are harmless.

Then there's a bridge window pin for this bridge window:

pcieport 0000:04:00.0: bridge window [mem 0x6000000000-0x60201fffff 64bit pref]: was not released (still contains assigned resources)

That window is pinned in place by sibling devices so kernel cannot 
release it prior to attempting BAR resizing, which in turn prevents BAR 
resizing from succeeding as the bridge windows cannot be made large 
enough.

You should be able to see what the siblings are easily from /proc/iomem.

It may be possible to manually remove the siblings first, resize the 
eGPU's BAR through sysfs, and finally rescan.

-- 
 i.
