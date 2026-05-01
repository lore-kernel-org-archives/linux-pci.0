Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041383E8C5B
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659437; cv=none; b=AnHJ8vol38hPdYL7DFj6HY1lASS2MJ7Qhkumc2cIXtmDhnKctdxGNFn2G5j+yuEvl36GMtuyz2olOjHPvV3fn/D83DNkYW93aHQMQwlkbOh12mNT+ahc3wE4m1Sryc01RTefiaVFkhdnvf/+ZZagBdZUtKYi5CG9G4Xeb3gHoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659437; c=relaxed/simple;
	bh=FuyGme0uC1dQYmMPiHV3ukU8NV7ufPunP8OPpbJlgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRWu/sfyruGOLCeaUR94MxtbbYIRKrPRfQYhqUVZVxPubnbTf31n5blJNEr4yAIbKeW+L0ndaKf3hdvtO251W6IxcIKy54QwaLSPuaypv2kAXZX1iO5n744RJIIyeB2vmNoJFMXc+WR39flNEcEG6D6xgYiNwqubyDIXKacVyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D46tWoVn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D46tWoVn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso9885ad.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659435; x=1778264235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=D46tWoVnQVDINwGSZrLtg3E/F6Loq9eKjxE/OBj778kiTAR9Shj5k6HYMJGK3cJ9Zt
         2FCk8EmL1snP6G51sQY+WTpET8kFtvqd/u7zIcRJlQ44QhBb+rNmeuQnFsjyVP5AGm6V
         e2zZHCLj2RdttaoSGXwLtzdxTRoSfwmMQAXUA5Nux2h2wVwyu60GWGZVpDZwY6JqWwfe
         xwcdfNdR+/tI1IJqS4TnF00X0eh3xUdqlOF8/RPbIHLyejIW+J0fz8Xif55XDXYTkUXu
         1Hwdq6ZH03gmCYyBAl50q0UQ0SOa0YVs1fUUABnpeyvZSIUlFOerD1lL4U3P2zDuTcuS
         VH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659435; x=1778264235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=oUn6KbcDgc0MpYcUlt9mHw1UO0a5CjtIlgELXcdlN8ueGMyzzou3dLjV4ImkiJYRsn
         I6sOMlr36U+7HrfKq6tY3N3Pob6WVsiNxtAfQ24tMKcVnr7EAnV5TKS6W1yPH1Cpem3p
         0cx9q2uEGU/tgJj6W2m2Yjqcxh+wSTyXxqBaBYrtjL1/pJw0D0nJPHNzajQWWmBunRFk
         ZqD/UYiPG3qWaGC2APsP/N3m5DhQqVeixpLajNlG/Wxu15OjSV9SyS7t/CKUOOvFU7QC
         7/VHH6cLYmShtEw7EUuY66l96tahS0LHKUbaQhbHAdGhbAQdaJ8arR6z0BmmCQhANQI6
         WemQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rQHBcwND7DwWL9/uR21beVVYXP3abq8C/4B+wTNlhXJDOcAQsap88D1viRtmS/8/K+tmtV13pfDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzI/2SzNw0xAN/s75tuRD0pApFc6z+CGkAEmNFSrVH7XA2HJxs
	399TIl645/zq1MHSijC924nQAgKjTrKcrJ2SYCFxx/ZNa8yPA26uDhivU2Ci4ST2NA==
X-Gm-Gg: AeBDietklZDYOTOhH7qzm0IjbEmpHwAtqr9PRLZFIqsXEXUwB9DQ3PBBZ1wuex63kQN
	Z/P5ET2orAAGKAv+XCZU2WWf2d67/WtiZMMziOAw0hFr9bZXy8WcS6DLB3v1Ss6T5GdWXD57+vz
	B+HzOGAlfVeAa35h6DEeEt87ID5ZQO1gmssMQY2KL+YIpE4nphRsOnhgACvVV7dXSG5LdtRznmH
	i8PfWB9Kx2rd5w7jxKpnANDCHho+3MpD67A9ImGW1wBOED7USUDAAw9bEENQa2WJFIDOVG2C3sU
	6tIzNHNfk37rl0ZiBDHoq0xlQl6OxgHiTyCFWg7y0jg6Ej450OezuzJD7I33A+LVXi0Ee2X/SAm
	s6dxtfp/lT1CebeOBaw+LhEi01mWSOJb6L7hn9Cvb4ITjNOuoP8HKXRt1jVvWUH3KhQwpH7qtJL
	r7dL6lpBbaurHmdZWDkZ4uHQ/0l0BFxQkb0BFhlXlNyJaP0qlagY8TELGopfnWV0f5gEAvCTEdD
	h1BijgEtYV4BwRM/6s3hA==
X-Received: by 2002:a17:902:cf4c:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b9f38a41abmr300485ad.13.1777659434630;
        Fri, 01 May 2026 11:17:14 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc85c61sm2776855a12.22.2026.05.01.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:17:13 -0700 (PDT)
Date: Fri, 1 May 2026 18:17:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afTgOXpUNWMapPAS@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afPGYp145FbrvURR@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afPGYp145FbrvURR@google.com>

On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
>On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
>> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>
>> > +	for (i = 0; i < ser->max_nr_devices; i++) {
>> > +		/*
>> > +		 * Start searching at index ser->nr_devices. This should result
>> > +		 * in a constant time search under expected conditions (devices
>> > +		 * are not getting unpreserved).
>> > +		 */
>> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
>> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
>>
>> nit: Maybe we can move this logic in a separate function as down the road
>> when we expand this to add VFs and Hotpluggable devices, this might
>> change significantly? It's good if it is self-contained.
>
>Did you mean to leave this comment on pci_flb_preserve() where it
>decides how many devices to allocate room for?

I was talking about this one, as I think depending on the scheme we take
this might change significantly. Just a nit, you can ignore it.
>
>> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>> > +{
>> > +	return dev->liveupdate_outgoing;
>> > +}
>>
>> Is this expected to be called under the outgoing lock?
>
>For now this API is only used during shutdown, at which point userspace
>should have already been stopped so drivers should not be changing the
>preservation status of an outgoing device. So I don't think this needs
>to be under the outgoing lock, but it would be nice to have some more
>explicit synchronization.

Ok that makes sense. I have similar cases in my series, but maybe we can
add kdoc regarding these stating in which context this is expected to be
used?
