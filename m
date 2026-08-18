Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE84399C4
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061788; cv=none; b=eO66kz6MIRvRm7q1ZAEdmG5b5iUpm9RJwonOqlD0ROBsHGvabAWaaCABYjmdQDzACWHRzD0wjLHiFJxPVB5J0fnlAv6AVI5TIAics5pg5yIgDuUfwH2Y+qxm/zZ10N2Dw9Qlt2DzYLKWoF2e4+JvvMGvz+Y/oPuZmoBmS70ENzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061788; c=relaxed/simple;
	bh=d1B0qUPbS48F641r6kvPXsiO9Yo9EqndQ9Hsq7NAwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSjylF0QcbAFWgRLZ7WnDJ4dEoZUPi+Edd/RPRsdJ6goiT8dTCicG7ARm6u1tLBTrJ7quLBNAnXWQkyCEmwsRCUL2NGHSGSt+YhN/ziyAGcHMUcywqM/l2oZMhNrd66VfyqTivPZtPRWbViTEkX/NkN7Ehr7wBovhFo+UF3RllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ok3l7wEY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ok3l7wEY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930f4e5eed1so343873085a.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787061786; x=1787666586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMpZaW96adLhqubj4u/1vPkdyrNNaeXZwvHJTNsBifw=;
        b=ok3l7wEYMuwryJeSQd0K+L1sJKMVgsB4dJGooCEgVAj4eIKQ5N4oCh1vte6dMib4+I
         6clkRMnyBz/oeZa2W7NsKf87mU7P5YV8Le/q2LEZqFJCNp7V3K2yg3pIpyzbj0r05d43
         04pCjKxaa/W4RXtjFGvdv439wN7WGH+g4Gs6MglmBlKYBHLaE00/eHgqPFKSxcoqK2Cl
         nQXBoefbUkCDogmhYBzP6st5h9Fgv1y6zYBSPGhQxdx+byu1/u34PdOKEUZTXrEqeOSZ
         BZjXV2AzN70GwVpowqCDO31vraI4aJWEDM1G+cTXf9rzy/VvMkReS3bi5jKQPkGZZ1iJ
         wtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787061786; x=1787666586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMpZaW96adLhqubj4u/1vPkdyrNNaeXZwvHJTNsBifw=;
        b=QtLFNu68kECN1D0O6x99NlrhjrVIiqTvSLPqnkI9mRVCQ1FSORCE/uytOeLqM5mbCd
         FfkrOCrbcbueTnkKMHOzu2gukSnGr0W4Jhj8meyk38r27A13H1kJFzZbhrHxZb+fAM4E
         ootJyq3NbYDILzGgAqmsKf3TiunrNmatZuqW+6Nb1ix5PqbkKLHaICcl9cfwerA1u/9Z
         hH4xSfRcF+DyMm1kxVUpMTrUITvPsnRQa1JMFwaWyUPIl5hEfc/qCmsFwKna7avbE2vk
         p/9gQez9wX+TJzqBQpsMqBly3zhXGFl4QGnxev5gha6oW02NVRXPISWTJnHp8RtdmkId
         r+Yg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3n+HcW2wXTfhwGg6NMiGAEVhP2wDwlQe9g4ucTl5+ivKAckLW6I10S+LuSZ7UU4dFsVNrpQJO54c=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHU/DXIxbJlSx+wYgupJO6ONugvdgpaavyp2pvDIEEUmA9AFS
	ycxxgBbEByB+xBSRg64KaGQU1HWpNmhSrb8xICORJzfiAw8rLFkOIw6qzH6N6uswDNM=
X-Gm-Gg: AR+sD11Ru6xNWylJozN7tmW44COTevgUTiVdDjcFfUGGUnRD5YKPqUoO1XajO6oKYdh
	pQWbLkglVD8gVUuysOGeErFlBD/VDnuGXRvaUpLUH3KSe5aDD+W8o0o6RENerxEym8NZLOjx/OC
	b49gtQL1W371Kl4ausTwdv64adKg0FIBtzMh2uLr6tRTrdO/yDm+BvFFgcSwD5sXbF6XIAMxpgR
	FVDs1ZzRuaU8lmLBQvLDowUhgzZqm2OJZy/CyI1JkymQ+JWnyh42E0AdxQIOPmbauxUvh4KMjn4
	5GlQI30OjD+65tKyNN7namwGT/soGVu7miituboWmheKvtMCJ4gvjdQA0korpfIWAW5H1oEDURJ
	RNB8XqFRCOjWFhcT8yaCkiddXHqdaSv8n6neEmtwDdA327UxKuMyYDyeCudee+Sh0Zd2fsdPCzR
	iSZSWm6fMddSY0Mly1iPUrmLYSmmNNuee52QWH16LBwBHF6Rn+N5SQfjzqn5AhE0rwenLiKnJlJ
	10/wvv9Rxlld+9mVqADgdlr4X6m2RCxlHJWmSvSLF2XDQ==
X-Received: by 2002:a05:620a:8389:b0:936:e906:e546 with SMTP id af79cd13be357-93704bc63cfmr900778085a.39.1787061786112;
        Tue, 18 Aug 2026 07:03:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033cd8a7sm297845385a.28.2026.08.18.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:03:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wwKPA-0000000041s-172T;
	Tue, 18 Aug 2026 11:03:04 -0300
Date: Tue, 18 Aug 2026 11:03:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260818140304.GC5482@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>

On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
> 3) resetting a PF due to ad-hoc FW error
> 
> e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
> reports broken PCI. Sounds a similar condition to AER.
> 
> but as it calls pci_reset_function() this series causes a regression
> in case of active VFs. Is it desired?

mlx5 does something similar. RAS flows require detecting the PF has
blown up and resetting it to bring it back.

This has to work while VFs exist and bound to kernel drivers or vfio.

In the VFIO KVM case I would expect the VM to experiance a RAS error
on its vPCI device and trigger a VF flr

But we have to sort all this out through the hypervisor to not crash
the machine or otherwise :)

Jason
