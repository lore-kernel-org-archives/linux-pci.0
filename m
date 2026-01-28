Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803361EB5C2
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591774; cv=none; b=qGBbx5JO8ZUJHvkWX/scbBi2gA6FAg14wXrL8t32to5h/kjOjuyuJ5DuB25u76lrpKCepd1W9HxU8Ci3h+88bbyMCQXxZW7CwYgDj36AbYnqVErhFbDLv4RTKi0EO/VZ2MmviNkf4xAVa3fQSaIzLRuS83LlATA7zFR1446mD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591774; c=relaxed/simple;
	bh=j1CnYGmZIfQr+2TUxkEO7VRSWGiBDvRuGUQLR2nTqDA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IcCHHWp19/IVUrfhbrv7eNwiYk+OWsgqMrgpxQvSotI2zjh9j4t7Yh/64ZIXHcqGGq9SujrFBtaD4lhvbXXOixzKDgNIv1TK5XDTERSHu6N2Uptug8GYDJUQXt9QOHWaxv9zSWX2e2peiS309wdo6aJc0hUfCpxzJTsnSJDGpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbOqfS1H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbOqfS1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769591773; x=1801127773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j1CnYGmZIfQr+2TUxkEO7VRSWGiBDvRuGUQLR2nTqDA=;
  b=AbOqfS1HuB6VP5Ynb7ZqyAwdqqfaDHmMHHvJ+Zzs35/YpfO7ZdhBu6AF
   q/nS6cqB3zPrw69f+xkfvsCgcwEMGUXZNQTMUi7yOU9M6xPU6o60/xh3+
   wpCPeB1IfBtKCWmUXZRGtFhgm1+DkjtzbAzISbrbFs5PlkHuwLcbRB8uw
   FrAVnpX6Q/I6d8K+9NbDiO0DMrf4rdyP/6tcdDCYtcZuBh3sSEB5AT8/c
   QMdeMKLo0zH9B5ig8LDQHUorJueoZrPsupa8aY5r/aqa70VtvFHTW/PKB
   KLRC+YJHTU1To6Cgn1BHrDP7Wnpb5PNAhIoVJmyEufd4utYiBQAgPHmNq
   A==;
X-CSE-ConnectionGUID: YyctKJBHQcWwEBV01eMVVg==
X-CSE-MsgGUID: 6OjmVwXzRWmgTDdDHR65Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82166269"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82166269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:16:12 -0800
X-CSE-ConnectionGUID: k5XTbrU3Tk2V1c1GDlWUtA==
X-CSE-MsgGUID: Ikcr9+HfR76W+n9eirlVLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208453197"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:16:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 11:16:06 +0200 (EET)
To: Keith Busch <kbusch@kernel.org>
cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org, 
    bhelgaas@google.com, alex@shazbot.org, Lukas Wunner <lukas@wunner.de>, 
    helgaas@kernel.org
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
In-Reply-To: <aXji6yYImTyT26Wm@kbusch-mbp>
Message-ID: <0637bc5b-afe5-80f0-8d80-7e6d1e2eea15@linux.intel.com>
References: <20260116184150.3013258-1-kbusch@meta.com> <aXji6yYImTyT26Wm@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Jan 2026, Keith Busch wrote:

> On Fri, Jan 16, 2026 at 10:41:49AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The device lock isn't held if pci_bus_trylock() fails, so the code had
> > been attempting to improperly unlock it.
> > 
> > Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Ping?

There's the older patch from Jinhui for the same thing:

https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.2555-1-guojinhui.liam@bytedance.com/

> > ---
> >  drivers/pci/pci.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 72d88ea95f3cc..3378221c5723a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5494,10 +5494,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
> >  		if (!dev->slot || dev->slot != slot)
> >  			continue;
> >  		if (dev->subordinate) {
> > -			if (!pci_bus_trylock(dev->subordinate)) {
> > -				pci_dev_unlock(dev);
> > +			if (!pci_bus_trylock(dev->subordinate))
> >  				goto unlock;
> > -			}
> >  		} else if (!pci_dev_trylock(dev))
> >  			goto unlock;
> >  	}
> > -- 
> > 2.47.3
> > 
> 

-- 
 i.

