Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFC277029
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445673; cv=none; b=NCfOGkikUIHGRgS42GDukNXXDml1KywwpWVc9YpAba6cZX6HnftPkFjBCZ+pjSnjoBDtfNTwOr7xU1Ls7aDlWuNjvMdf0ckdwhgFgrxMeQBk8SouRgIorCaMgY7MoTGcfwXD1Pj2nNGEvu3hHAIGmPPf8ueHnTMq7owHyzhGnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445673; c=relaxed/simple;
	bh=0/f3k6YhFFNYqylgqcMG4vpeDMtx34OA88JRI3jDl7g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dLVbfkFGRVJhVZEDkENVXqHYTCY/9pZFGxtjBTy9KSOlLt8HAqmYgcCUKNoV5iUAeiSbr1QsIRJuUtDD4uWRgWcph0UsQALw1cQHGz0B6ajHNdGPz59szDhb9QdUGhdCklXkRJ2phMpbZIFtChKRLgTKep9zD/gjN6UIyyXn5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DSz02o+6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DSz02o+6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9159477c893so296613485a.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781445670; x=1782050470; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF8u6DKkckQuJavK70W0G+qrxbgEHWN1DTuCSFFIGv8=;
        b=DSz02o+6IG0PoPPDYviGJPARiKTp1DtWzwKTj380Mt18AxwwiQOVr8xPTQtflEbBvI
         gT21P6J7Pyg/ZVRmK+xJE4bHbwBtHze80+sNTS9O2V2+EucczK+L08JF7C9hIsTPm/2U
         +xaGZCsQNvHkOkgUPFZ15Zt4vzukpaiXv3KLmcXrBjLl6LHROGMwWNXn4yKVH4VcPiD9
         6YYZZvOOOiPh54QaPh0FXatkkUb8Mso3TOm7xDGitrqxKzes+z3PUvkvM5cyKIDNVTp9
         zuhl1YOtjRPEP64n2m5vZZQe69PgROUTexzru2X5oeayzymFLAEeOaMUApNV4uGFvmko
         AA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445670; x=1782050470;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF8u6DKkckQuJavK70W0G+qrxbgEHWN1DTuCSFFIGv8=;
        b=EF029L/jaZZeKEFun4mAj0sNw7ec28Ir24+mTEaI+xSCiv6cqZeWKoOTwuEu6YbLvT
         +7VIMrtiXQglvALoMV/w5IrU9EsazRw0spRNgfOJ41rzlbKYRsAW1cIJVA6wNc8EEwJc
         0OeRvXrnNbsA9YTPHXt4q1oghtZoWG2iTa6zlFHvZRyKVOQOcFSUIa7aMK7Pks37uQUu
         R7iJVFtm91bnAfUCHGqqrucHKKF0Fs8lVs4q2ZYwKe1Eaf4diGQW6hMft2j3B3EfEx/n
         mgc+z/0sWWxVwepk2+6hF6gsF0PXJCstQsBFp4Gy38HE2ibt4y1PvUWOuu5WdTbrHFqG
         y5gw==
X-Forwarded-Encrypted: i=1; AFNElJ9pO1qYemtRfYVeOjntoyg7NecJE4HybzwvpyVl9ZqBWMXXJoa1fXB0xkdwNuGV8uMYUkT02TDbV3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqJfT01vmx//ndOI1RrEBdeLMW5Hq/iSU8UJAEzNrTg6BMWw8
	ACi17YZqP+aLtwjD0YsoYvVvF55yXw6KjSJwQiIkANGZpIHJcAYgRHldRHq1ToFPcgLo437FTdW
	adpW1
X-Gm-Gg: Acq92OFsg272EYpm5z7xsTuzcEnLiYYlI2LQOKM7niBjvdq+lTYzMTTQaP17I8YmqKZ
	W3lVTJRbd7Jg6p6z6mHw3V5l5eJzC0WMubTrkvRTUSX4YOaP7mNTHid75jVbmXc42LQe+/Wwl3X
	0ng/schz6PC1Z8FT/FcLsZQu7/oyo6aZzhX5xy7KkdYTx7IuQOzie8NEnFZgE7t51nu46oUxu1C
	6IPB7TatHbgIBr9+gzXWaW4soC2LNPwXxv7YInEJ35OpdjZ5qnCj4+jvjT4v2JqascCN907hzcc
	redwUsmL+8TLystiRVigdxqyXM94xjyII94rH0Ija8qATdsKlaSE4VOy3+PL+sXoK4WHxMWM5us
	ZiDT9XrRlWnXpt4RFZ8yVin8fCWzQto4xKWqj3gZ2awF1k/rvMtMKqdk/9UbNXhUvKAP7zizrp5
	+jJ75nOZ12Q+zGRDy4HbhI3K5+pIuj46NJD/qxf1RKbQ64UTLk0I7+sg+Dki39Y3usZKt/pCY=
X-Received: by 2002:a05:620a:3705:b0:914:ac45:a98 with SMTP id af79cd13be357-9161bb03ad9mr1608583285a.17.1781445669356;
        Sun, 14 Jun 2026 07:01:09 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fe7sm806892185a.12.2026.06.14.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aiQAJRINEKiwCmVm@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
 <aiQAJRINEKiwCmVm@google.com>
Date: Sun, 14 Jun 2026 14:01:06 +0000
Message-Id: <178144566685.1266136.10385355007970146916.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=0/f3k6YhFFNYqylgqcMG4vpeDMtx34OA88JRI3jDl7g=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLrQjWixclC4MmfNpLIwWFqBCFzofhX0Jr8QQJ
 bpVL95JpeyJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai60IwAKCRC7dyhM23N6
 3kUaEACol4WdgDqN/9YA64JobY3TtWyKckwy4VgKxaRGy/1HiRGiXX5khGnvPxf/QUt2GqkrOAD
 9bfcRjR/HmwRhjEO8hkWUhHd5uwowgrsW2sn3Y0fs3qD3jwY1OCZ9WdrkMReE8b3B3ii5wzbOQd
 +dlUHARMl3hjaiT9TSaHtHOkmSDKHM1UKPlzTWRDrCmh6+LnpuOakhfPOKFldJYDgw/YIBKmZQG
 +YIWAWmBPRFGkUgCD9FoglbeuyIym39QFmBpPde0isIetl86PwQReKOb5H2Zi+aD+mm4ine49jq
 KLbeKAxjqxMj1cXWKk84Xe40fr4H4wkU4vsfGH/eGK1o3wiQVoBbu2TPp1LCeB9N0cNWCVE9DH0
 7EizDfLEBK/1DKZaUprLyucUu/eA2S/S254GS3Jn5LDRzlNOj1al3yHR68VyCLeMWcZA/VgxYI5
 dqQYd/bN6gOvwDlFB/xexPatXErOhIo0iGC1i84tXL4C1OQEi9uIY1CtDZ+Ztv0pgUNlVOhFyGb
 kqDZniluCNmnn8OGPvNMZz+sCPJtmqQBEATH2Hv8dlOdlb4s8lSUeGD1aBMvKPKB5Bh0hAczvNh
 Sj5W6biG4ZUAj1L8BivCr0gTvsEJ2WSr9VMRTzsZ+0+dMV96HGvU4RyHQY7IY0Mx6kLObjr8TRS
 KOqR+oScoluku5w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On 2026-06-06 11:10:29+00:00, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
> 
> > During a Live Update, preserved devices must be allowed to continue
> > performing memory transactions so the kernel cannot change the fabric
> > topology, including bus numbers, since that would require disabling
> > and flushing any memory transactions first.
> > 
> > To keep bus numbers constant, always inherit the secondary and
> > subordinate bus numbers assigned to bridges during scanning, instead of
> > assigning new ones, if any PCI devices are being preserved. Note that
> > the kernel inherits bus numbers even on bridges without any downstream
> > endpoints that were preserved. This avoids accidentally assigning a
> > bridge a new window that overlaps with a preserved device that is
> > downstream of a different bridge.
> > 
> > If a bridge is scanned with a broken topology or has no bus numbers
> > set during a Live Update, refuse to assign it new bus numbers and refuse
> > to enumerate devices below it until the Live Update is finished. This is
> > a safety measure to prevent topology conflicts.
> > 
> > Require that CONFIG_CARDBUS is not enabled to enable
> > CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> > bridges requires additional work but is not a priority at the moment.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  6 +-
> >  drivers/pci/Kconfig                           |  2 +-
> >  drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
> >  drivers/pci/liveupdate.h                      | 14 ++++
> >  drivers/pci/probe.c                           | 17 +++-
> >  include/linux/pci_liveupdate.h                |  4 +
> >  6 files changed, 119 insertions(+), 7 deletions(-)
> 
> [...]
> 
> > +		incoming = pci_liveupdate_flb_get_incoming();
> > +		if (!incoming) {
> > +			dev->liveupdate.inherit_buses = false;
> > +			goto out;
> > +		}
> > +
> > +		/*
> > +		 * It is safe to sample incoming->ser->nr_devices and then
> > +		 * drop the rwsem since nr_devices will only decrease. Thus the
> > +		 * only "race" is that the current scan will be overly
> > +		 * conservative and force bus inheritance.
> > +		 */
> > +		dev->liveupdate.inherit_buses = incoming->ser->nr_devices;
> 
> Nit: inherit_buses is a bool, while compiler will handle it correctly,
> maybe we could:
> 
> dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices 

+1

> 
> OR
> 
> dev->liveupdate.inherit_buses = (incoming->ser->nr_devices > 0)
> 
> for readability?
> 
> > +		pci_liveupdate_flb_put_incoming();
> > +	}
> > +
> > +out:
> > +	return dev->liveupdate.inherit_buses;
> > +}
> > +
> 
> [...]
> 
> >  		/*
> > @@ -1497,8 +1501,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  		 * do in the second pass.
> >  		 */
> >  		if (!pass) {
> > -			if (pcibios_assign_all_busses() || broken)
> > -
> > +			if (assign_new_buses || broken)
> >  				/*
> >  				 * Temporarily disable forwarding of the
> >  				 * configuration cycles on all bridges in
> > @@ -1512,6 +1515,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  			goto out;
> >  		}
> >  
> > +		if (liveupdate) {
> > +			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
> > +			goto out;
> > +		}
> 
> Quite helpful! Thanks :)
> 
> > +
> >  		/* Clear errors */
> >  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >  
> > @@ -1572,6 +1580,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> >  
> >  	pm_runtime_put(&dev->dev);
> > +	pci_liveupdate_scan_bridge_end(dev, pass);
> >  
> >  	return max;
> >  }
> 
> With the minor nit above,
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan


