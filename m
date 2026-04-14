Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6683E92BB
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179489; cv=none; b=nnhPSEn6nZIu1wSewc2ypANq5lcwopbyUKodPKywgwA/N8qcUySCpRqpMIAfFpjE8VhyBd3BRaWFAxF88RLa0Wa+OwoxjYJFW8lD3SgCqiWjmwhBl24ENpqO//yyk8oxzFkOmZjLzNuG2gVqwBFiEMyhdrls1skaUxgAfAhMlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179489; c=relaxed/simple;
	bh=wtmKouu1J13QOKEWpC/Rhgp+PUitDlJyO7jIdqkEIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsTfZhP5UNsnsSLpRj6TpzYZmvy5ZE5lyn5Y5w4HFZdFGxfM591T9NU0kFJ+FYjn99J4nlOG3Ts1PX5AfNBHNA2HOVpDzUgMa7GQF017CvO7NltKBMTV2mwwtnAUxSmsSck2dJ6xVqviwI3LCTeU2B76MvFZtnzSSEfmcMrAGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LOR05mK+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOR05mK+"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso26922216d6.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776179487; x=1776784287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=LOR05mK+HpHUZy18w4Dk7mDIMTVt2CqGJv6K1mBA55KO1uywBz8h8IBKBzhn4aHAO9
         vH0NS+fuTcuiKi0VoxchkLiUtLN6rj7dqxajvrCuQyW0IdXx5NElXiYa4YWn5DDd/BtR
         WFgWMEErubR+eerVtOWit7waU1BfplQlQbeI0ukBBX1Hfp8klPZxXlCJOs/B4824tYD6
         vOMiryVGnE37XdbdYE5g3wxBwhLNymPEJbmA6ALYM/d6B+I5HUMss6Fc9WF0N1a3VH7u
         OcXMJI2BDU4/8aMgg7lU7yp0PYDLaJwX/fP8wrU46jXXqbpXimJy41RSnyg/4SlBtXPv
         9LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179487; x=1776784287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=EEJK7ne7ZyglBD2AWPxSmmyj2rtSyb6EmcVYO2VrTNS5F8wfMETCc3zO/979cFq21H
         RGxUOboWw+JPPyrVBf/L31L9+sIHe21g2qOBfLJ/VdoW2mNSq8zOQVnyjhPuteFAm3ow
         hHouXUsAjF5c8G7o7jft/jkSp5itJPj41sbOQq9A7gjkk9Kif+1GSxRGedQt9WtXgy+U
         gZUBYpU2SY2n9IOUrHqQR7Am0Lani4IpaipIkZplFCaRBsw7pdaWFejZP2UZJA32FVT4
         gnX0JP2kOnx43HhOyRTJGChp8DpH+TCPl4yfpdC9HaCMcgi+RXQ+OmLqEPzPlwJ5ky5j
         2Vfw==
X-Forwarded-Encrypted: i=1; AFNElJ+sC117+FdiP6JdemriykN0N4Ujf/6ZAnMdFxdISSljq0Ja2WRscaZrywmlyFgMH5XXNj9FBZ8d1Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnd2Mo1xzjPvY22ZdFpcRUhegE21zK+8a/TUVk5QFJrWmr3/de
	5LvAhBGnjC8I7l6ekETIlNEVFtxNWHfGJthnUyuv8YGrtxwh/O5DBrDeG5s3XRpLfug=
X-Gm-Gg: AeBDiesbWDJQefox+PAWkur905NvyWA+uIbLmoDxk9cq2m8SpCAyTPe772WQHizSNNh
	TJ2eZtg/g9kiQYXgHvFTbaPHFzNjz12isusgUwnHRA/ZZJ/5NpjOkevAyGyXm23rhAoMCeksYb4
	JnmLqh57EtpLhKjxGUYUDncfrAjYeP4KTK26SLqxq24OSS4Jace6PWju4hHegayTEUSrwmlbMKf
	wO67//sPP9pfIXvAWSf4BgA/zOre8W3CqFDx7oGOYAgoRwBol/Dc/8zy+Ol3VrAdKauLDsRHG8B
	kC+CD+Mlsv7DFpHRaYcEbL2Y612JrJX0p3qCTHOrD7ES7AcJ4Zg1M6xW2sa5W3ajYU8cvLBpvJU
	0d5nWT5twiTrSkMKrRUomwa5orc0tGSjhi8wPkpByK31IJCa+6jCAAHe58mGKsUd504g++2K3IM
	Ef6FBdvHt27/pE3qv+PJS+TFA3aZSC39yWgby+XYPxBmoWRx8AHC/OQJwvY2Z+JTITTVJXZKa9/
	nuF3w==
X-Received: by 2002:a05:6214:4a01:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8ac862b51e2mr284214856d6.40.1776179487026;
        Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm159006516d6.3.2026.04.14.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:11:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCfQD-0000000BNfx-2aVf;
	Tue, 14 Apr 2026 12:11:25 -0300
Date: Tue, 14 Apr 2026 12:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414151125.GF2577880@ziepe.ca>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>

On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>    We have a real platform requirement:
> 
>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>      * 4. Userspace must program STs into vendor-specific registers

No, this is nonsenscial too.

If you want to control the steering tags for MMIO BAR memory exposed
by VFIO then the DMABUF mechanism Keith & co has been working on is
the correct approach.

If the VFIO user needs to control steering tags for the device it is
directly controling then it must do that through VFIO ioctls.

Nobody messes around with other devices under the covers of the
operating kernel driver. Stop proposing that.

Jason
