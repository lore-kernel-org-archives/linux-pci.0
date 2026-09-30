Received: from mail-dl2-f15.google.com (mail-dl2-f15.google.com [74.125.229.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BF4F93A8
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787161; cv=none; b=qjVJKBu6frRcc/LHj1xnZZlrmTchg2u7k6aCVlQukAuGjeLACe7icJvPKPXhTGWJjNnp+Vxf0GqXTRgP/0BaBCIWiJIiVa2Y0PzhTaYSJ1Lei9Ur6/V4tdl5f1Kau4in4ONxk2c/rn8NMOiyifoBDdtuy7mn3y8g55g44RP2dYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787161; c=relaxed/simple;
	bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Mg3SiFLffNaQeJucSwdtvzQXGWyxrH34fJXt3U72jJFlFecZdWXqujeJ9Cq0wKeEUakgR1eY7hOFGl8kdu3CfTA+tJ2m7Crx/R31m6HVRWMWD5/htA+NOftahO4zCuRuDkqrcS4E7evuBH2Cb1HGpLgZVmsCgVGgF9tOJTDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OhOI/Tgd; arc=none smtp.client-ip=74.125.229.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OhOI/Tgd"
Received: by mail-dl2-f15.google.com with SMTP id a92af1059eb24-14d7cc24630so177230c88.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790787158; x=1791391958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
        b=OhOI/TgdclwGcCILD+ANQGEgwuLJ1ZFSSM6jZ0eyyZ5+emPldVS5zYq/zAUpJhDnrG
         yK0jdBXbcETvevcDmN1A4j946Qj4hSNu0rKZCPee7rIB7Dqmcb1xcIedR/Bmt5K58SxD
         cAI3QtH0pMAXwQJYvhU8d0wGmHg9MdTQg5xMwKqWLaulux13gkarK7uX7e/BVSlO0NJ0
         L8y2Xh0n9cuFXrampV3zVqU70hZ2hbkcWrmJOsSLWkDdDLly1pNPqk/rE5dK6UpPfnjF
         PKz+PLpK+1hm3LyrH2xo9sMnWM9KVbPso6lmlhuBWaIZmwq4yxmEqHqznGVGaqHEvJIi
         KLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787158; x=1791391958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
        b=rMJRz4RFcdJrOEoxN7TGMa4Gfex7ip1yCNSX1QIkRgwgW2ct4jujH2MyX44yvLUmH8
         ALMy/U0B+oIwoz8b1mknoR8zTR6AmMDsQbUTNCF4MBYlB8FITnWj0X2d7zfZaVxwBN+M
         Pj+rGeADb3VxMaEDZHWtwQG1DUzDG4xN/HcSW/fMxcrrPuCiojPWiEr92IBaKTlVeijH
         xsrtYL21oY/EhljabKNwOllX1ur5fIKfHEQX1yFMNhmJAerUbOWoeD4h7fVQsHJwxgCB
         UlsPqtWsOYU36wceA3Tjqp4C5LvldzRYStRCukgZqV0RWXngQPLbNmEyFxER79Km1L8M
         B86A==
X-Forwarded-Encrypted: i=1; AKwUvBxev3dt3vlZtCZbJKCZ0FWutan05Zsvg9SPXPRuJ0PUt8BK5DP1d+2MMgYaz/zKP7Q8unXMpnu+vO0=@vger.kernel.org
X-Gm-Message-State: AFuF++nsRPT6UDzH8KHuO2rbUX0mTNgzem/uVqGT3zFz0m7uGlTPuAO4
	vgLxOkSzAH87BAOs/TxHT3OzOjmIdpatFLQmY1ngdoPb3zRktZAwrkUvn4C57hzKPpc=
X-Gm-Gg: AYBFou1dXf3MzRIXiwqqIKVI9q+EOdyBklXLOJ1PHbsrjUTibgmKlJQDcfBWzoNnpzC
	6FaT5UBbJAozPDsf6wmXS8IGfy1CyMdWiiK1Iq4czYnbHp3UafNmM5GPPMo+zMkZjGKtp4TNSwf
	+GqdRHUYVHY5rXPF8QCCjrAmB363RljE3QsIoeUc+5e7p1AiyPB8CCk5W+ugspwKTGh5EnBkJ38
	hr7BnvBOC+bSB+dKlsWn6hpFeqjn7CXvEgPpy7uW5n6zVsLEuEDNIcslsdJ9cnv6VkrsHvj7d35
	U5bVE7i4BSpXdz4ct8m3r7OqAHVQti/8ima2XMmDDq5dCqK3W0y4KhTI9L1Fs9/XHC+ODLmxOZs
	3x/qdihCYn2d6P5VZeg0ZZmbZimIgqVSsHQUINNyl2r1usWDfE4APT+Rb33zWdsAefevaBSVWpS
	wcjZ8hGdnqlSKoaKChMe7qRvAvCcgXn41USZNqfha/MaDWcA==
X-Received: by 2002:a05:7022:4595:b0:143:297c:276c with SMTP id a92af1059eb24-14d330b1ca2mr3017652c88.33.1790787158196;
        Wed, 30 Sep 2026 09:52:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d313b9c38sm4523537c88.1.2026.09.30.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:52:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBxXo-0000000C7JB-1eI9;
	Wed, 30 Sep 2026 13:52:36 -0300
Date: Wed, 30 Sep 2026 13:52:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260930165236.GS163130@ziepe.ca>
References: <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
 <20260930143237.GI3401365@unreal>
 <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>

On Wed, Sep 30, 2026 at 04:57:04PM +0200, Thomas Hellström wrote:

> Returning again to Jason's series. Let's say we'd add just the mapping
> type infrastructure, converted users of pcie_p2pdma only to use that
> and then we'd have access to per-mapping-type data. This could actually
> be done as a prereq for this series and merged separately. It's a
> couple of patches only.

I'm happy to say I found someone here to pick it up again, so we
should see something on it after LPC!

Jason
