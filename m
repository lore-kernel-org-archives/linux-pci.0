Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250144;
	b=HTyvxiIK60Xey4Eal43ZF32+Q7Z7inQ5XFi8ukWdx1KmloQw/k+OwLhxK0t46ENF1htW
	 hfaGgbludOO7d7IDg7aRM6/Mg9/xXpMCgBcF0LPJUUsHeC/XADVSxsWVPAYK8cRoK50yD
	 qJi847uZjcgJ7W0jebi+jI7DE2WLfVq75DnFmSc2nbx47zmd7nj6MhSo97oihWNhvJWhT
	 sy8YWUZTaL1mck8BgjzksDijD3UpxvqSaWJVOHrlz1Abdu8m5lsF5oKs8fL1OJRwZjcHe
	 wiwl1c4HcObzsHpofD3FcdR7e3h0p+B5J78TzmPscz6Dw1ewcJI1dziFWPGRGc9rnCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
	b=1Z5CSMltpBiln8tth4oJAnn0GQTaBX8qDQliJjwDXQTMr3gaIZVoqAPV5/UpiNkQPbdr
	 7+NZsWppEal71raSHf8MgH1Lk6oau9QiSbQUouR73GF8sZzc/k9Brkw8LMYV2/UbNX3iF
	 DJoNVQmZz1NAcr9jWvQPdiKLNn2WKrnACqdKJ07cYF4iIvmPwpvyk13NUeyNBKdsqkGvR
	 imn0RUEZuM2ruCRuHUVn+R1Np6BlsgFqS0ZK3clttK3UjkHUQF/NdrSdNteFoPpAjEA4j
	 fChXyTL1pjqSl+dK4E6PEz2B1h2RuTCbwEY++yAzMtAMqVgR2mtfuwClc5633i4NdhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PuTYdyOK;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C20606A333
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 18:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C20606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PuTYdyOK
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-537548b811aso9511471cf.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794250143; x=1794854943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
        b=PuTYdyOKu7rUl19nMbVLJ6he+g7v6e//cAur3W6t4momB8sYNUVcG6lgvYQzXWRQd2
         wePZJZy5/Izh8q/jhlELM4Aipu2Kq5puT9fASJ7I8RXck/tzsZK36x2w1kVB5L3uvFRk
         yCZ8eBzX92sdtZMINMf4iRP4iSymdt3sV7+lf2q+Dsmme4JB4gladVLELQlWGhTX5UO8
         5gjS4JxeWLhg0KwGwZu9rV52lCtsH+msY+e7JnZinD7YQ8GhOWkxw69O2Z8OZoKSY78S
         rg/ompvsongIANmOMkI5ZtERdMKe9Hsz2Yso7Bgyp2VgeTgP3bwtobBH8NpvH4k6adr8
         N8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250143; x=1794854943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
        b=qsMmMW8gFhqe82ZUT2/j32KFp7yXdxc/tqab7oOiV+kI5M0+YvgrkXh4eV1Vp0FsH1
         qbiapPF4o4dtnisH8OYQh3LoO8AbtrfirOdQjtkN0iDcfPx7U7W3JisD0TBKHnRSqJqI
         ZZYriimxUEZbl4JzUcqXVZUSnEKBTlZRqi0pYA/BZO44eR2t8e9lT9cJk09Z9RMesbsS
         197vRXc6hvNc+OpCJeAlwVLkTSzdWshNvBEi6bWcdsiG1V3eUAlBpdHFHHBR6UGbP1oa
         xBiF4FLb9u6bgJjRnf8VaQzMcpU8s7V7vZ5dhe6pwCv7F9rZUnSixn3uf2S+KaTOJ8Q5
         7uwQ==
X-Forwarded-Encrypted: i=1; AL+hErFuI+R5pRKnk1CkguR2e+0MhSlyJGYeaJ+38ulJI1HHEr6Ne8rs9WR0mI8KW0zUroMi4HEHXrYoZe4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6e6UNJ8Wzv4r8E6IZgsTEHLo1i2seZemVdFzn7OuSywZ7v509
	xWVNA7w3N/i36rGC5GrNElPTzzIJTKan/8JrSaHzy9SIFKJYANcigVj9INVXaFt3BgI=
X-Gm-Gg: AYBFou3oNEGMvFnO4cybL1HSyf7iC0VLWXqjT8YInSTTY3HLStWFoqD6ciY36CFKcMk
	5NlnJx2/VFkh/+KMWeJEtf3ZKhYqGqEEV+dQ3FUy+khE8BoSR3JD/AkJY9Qs1KWRWbgmcBDJx5c
	loiLG3ZI1f1Hewc4kKv/ZaXHBsDYqL98enBmXwr3OIeROHwpLsKzzzaJSahYhNl5zVM1+MuEIOG
	pHzk02wNx9JJVKEsh4xUDMbJzwM+PEGibQtLnHnNHZGjfx0T+gMPbvweedjh88LSEUmYc2umXic
	anpJgmLJJI70Q1w0QUrwGEyc5TzdSC1EnyYCdek6BhYuQXBvu5Ot4NDa6mzIil7S9o6pVarcMvS
	k0LRwSVwYSJFRaU9WKHItkWODGNiXVfyB1fDZEI/nBwrJMOGeR8WtYajU0w9RLa3euse2VBT/M7
	r0l6uOFtkrvu+i3E9t3iRAnB/wXtT9S2pOLlsfQCGIk7Ot9lyz0GRjxjBkneJzFREBiEC9iyMas
	E/9myCChyx5gDT/yjlvcsjPTjV8waP5lhhIXo7+2r7KrwkyvAi/xWVBFf+s5nJ2pbvPgoZCxDYM
	LmpT0SB2le6hxFYFN1vOJscdkK2Uvom8C4HahweDyJq/lugFTLLVfN2vFCypaJRfnl84iWNErBu
	UqgzpwOgtSYzT6KkPhOLLjjyK4j2Lfeg=
X-Received: by 2002:a05:622a:40e:b0:536:3600:f0af with SMTP id d75a77b69052e-555253df92fmr3996711cf.7.1794250142846;
        Mon, 09 Nov 2026 10:49:02 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af60493sm3967801cf.4.2026.11.09.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:49:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQUQP-00000002A6b-35np;
	Mon, 09 Nov 2026 14:49:01 -0400
Date: Mon, 9 Nov 2026 14:49:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261109184901.GQ663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <20261104152351.00002565@linux.microsoft.com>
 <20261105004934.GE3889730@ziepe.ca>
 <20261105091622.00004a9c@linux.microsoft.com>
 <CO1PR11MB48352506BB91C461F25147098C762@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48352506BB91C461F25147098C762@CO1PR11MB4835.namprd11.prod.outlook.com>

On Fri, Nov 06, 2026 at 08:03:48AM +0000, Tian, Kevin wrote:
> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Friday, November 6, 2026 1:16 AM
> > 
> > Hi Jason,
> > 
> > On Wed, 4 Nov 2026 20:49:34 -0400
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > > On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:
> > >
> > > > I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> > > > leverage this? Could PCI/TSM support this role without
> > > > device-security?
> > >
> > > It is certainly not what TSM was originally imagined for, but with our
> > > new arrangement, yah maybe so?
> > I will rebase on this set and send out patches for a detailed review.
> > 
> > > TSM basically just becomes this weird overlay driver on the PCI device
> > > that does stuff. Some of the stuff it might do:
> > >  - Register an attestation subsystem device to do SPDM
> > >  - Register to allow iommufd to create a viommu
> > >  - Some status sysfs ?
> > >  - ??
> > >
> > So we may expand pci tsm to have more than one role? currently it has
> > one.
> > int pci_tsm_register(struct tsm_dev *tsm_dev) {
> > ...
> > 	roles = is_link_tsm(tsm_dev) + is_devsec_tsm(tsm_dev) +
> > 		is_assignment_tsm(tsm_dev);
> > 	if (roles != 1)
> > 		return -EINVAL;
> 
> Not sure what'd be a proper name for this, but it sounds to me that
> it tries to over-abstract something into tsm. The reused logic related
> to assignment or viommu is relatively small, so the other option below
> sounds better if it can work.
> 
> Or it may be the original provider framework that Aneesh proposed,
> so tsm/MSHV/pKVM can each register its own backend...

That is definately undesirable for TSM

I think the very best answer for this is to get the viommu from the
"kvm" fd, I just don't quite know how you implement it..

Maybe just register something like a notifier chain where the struct
file * and the viommu type value goes in and a viommu object comes
back out?

Jason
