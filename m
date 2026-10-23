Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792912;
	b=rFGuo9ftEeUy4lBdh1i615sfaPYXkN0g+c1GOuFKmngv6qrsm2DWIdiZFOzX2mOHC07w
	 8XfDclRQkPzuJIR50QmJhmTGnENBeULyxsQcLT5mB8Bkq2I/NKlncpNd8lyfELOPx5nNY
	 l53l457LQadXqusRJyj6Z1CUg5FohGaXIZt6a4SEL8dkpDGNoBtngVfy/0SaP5J6gV3WI
	 XIa/myIfF55z8n862e013dfv9hV7sO8kFISCoo7OLTeJZ1Mlz6sB9ZrjliCvI0Swfhj58
	 ejafD28kyx2iOcUPSiAyZfYvtFhO2J0J/v71rsyhdVjBGZ6I+UBPVtADyOBL9EW4ViQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
	b=oj9XyoRJoWuEwxhYiIsnpDD6DyWvS4ymer3JpoaSGLKq2/md2kYHGnbJqzhpCJqMYSe7
	 EZSvv4D5Bbq1hNNoEmCmU9Zkn5GbsVh76v1Nnv2PE0+2acbPpYpqCdhGia1PGhv0MuMim
	 yAhsdkYGjaIVVrnwNRxZLvJXPHCfqO8qBAHRGr09JjkICQz42kNXu1ZOM3Q12OQjxIGV5
	 NltkUfqUBAu/A/iLt8cZ2C7SNBgfdccet8a8SGEb3dEj8BATizeZlmiDRfkcgGHs9ryOR
	 x2nkk+oxL2ABLq59F/Ocsbse8u28Qsy0/qyj6Imex5NbfhBkMmo6lfPkecJI01DxZIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H2Nk80SC;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF0606A31A
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 22:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H2Nk80SC
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53667180af3so14305411cf.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792792911; x=1793397711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=H2Nk80SC0IE0suPURnYr9e6hZbC4LBCNbP2UbticIu/vM5Zx8lZxl1WF9oIVeOGweJ
         W19x63RIXk3jCkb/8AZ9w0/6q6ZaY29bsZqX8VJh3ACjKIAi6gixXOH39qqPhJV0UGZD
         h9hrX7AQMBlOV6X6RgQiCpuKPLs0LqoIe0SH9hdfWiIr6eNHUZFFbT0I/kCisS92xxMY
         Ucn1ZlEpvxoCWlvTmp2e0dWk4YFXYfROdABgbIgP0F4SF8jcDI2aMT5TzMY19oaj7RhQ
         ktu/3+o+78VzxnRBhNe+IMPeqMjRjTTMOSsOLuA26L6BAOJT0HaC4+T4MRB1PHDXmGMo
         Ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792911; x=1793397711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=xfI6XpSZKEVZfJzhYcEn5NvCRf0QEzyjqQOD1koTVCiyCirvhAv/8qKaFoYI0QNFiX
         QD23mwu44YEQIlCF3XjbMfPsfKqT5zUG8VAJ+36EOz5scXXg3rLW8bc3b5eTUx3sT9YB
         uEjmCj1VTl10QWDiqS7Gw0Nv7xaDD+zZle/07QtK4Eb657TjmPyB3kAOXlU28OTgf7We
         r6HP54NnQkqbAYFtnD/Rut3FhOaIWISc1FVhj/DacNoYIBBUUZeMN1IrQCIsXfCgIjA/
         QFJSWILYy8l1UP1f2/+cxyytULrBvZ4l1nimFp2SSe1iWkuEOCsYh/vdP4FKOU1NzxRC
         DDhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZlQup2LyUq/VPpTOnJe3C8Ja+PpUzk+/4pXHhkhxWeha5p+Ejhk+B0Flq+cZ0fwiNCIXADT2t4tM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuS0uvu2ADEkp7M7qr6dVdzlZkyqX3p9YXYSIo1yQc20AYeOE3
	5tS68WpLAkVRPWWPkPC4Ug0FLkx5iNRu/K4HUfkcTqZCSQoxi8rSQ6bEJW7HDnMq3dA=
X-Gm-Gg: AYBFou2yePg17SVueqJLXKwctUuCFdnTVTASlTby2lwwuji4+kYr//APM5Wmf3jCGtj
	BVrc4roc/E+ke4peKklj5xKVZB7igFYYfwS66SU2x07POKeKUVlBfkaI5cWoLOZgryV4Q9RrWJE
	jeixMtt1pTUDjQbaLI4A+/JwyKvybMtwv20OGELAhtvUEVBlyU/QrhVojYrGL/5GYjS/yV7f7WW
	9vEQztm9+kAdkKLtU+cHtTEleUioit01j5Hw8rfGwi7F0SgcGO8fhDgzLedMIavYZxaAcoNFeGl
	B2z+F0gAVlW/rDt4d/wUaSchIrdtKwIpRNUta6+Q7Zstn0OEZSjQ9TB1t47xCrWLE58xyiNzw0u
	oOT9zCI9Xmp8NQn7doD7hPBwkSPIlzudz+QgqCmpYkiGQAA5oVw1FM8bpqisuE5VNGpooQgCUyT
	8QrnWousymsH/bPdNCYvOk/WDTKW4Vpl+I1+EHkyvOjN8RZDRccTtc+1nSJBjpDiaP5mM2mn+NB
	5MkR6M5xZ8tImUBd4I/GK++zJLjpm9y+zHF3SXGuxnLMqtniaqlN5tuuOZAFPmEy+uAB8giYUnh
	1e6mC0PPoEFLuTkNtXHGbUmNpAtyh5OKfRAA4g==
X-Received: by 2002:a05:620a:4441:b0:93e:c12c:f137 with SMTP id af79cd13be357-940ef9c87e0mr54142985a.82.1792792910841;
        Fri, 23 Oct 2026 15:01:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm18520585a.30.2026.10.23.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:01:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKNKe-0000000H7Vk-3jIV;
	Fri, 23 Oct 2026 19:01:48 -0300
Date: Fri, 23 Oct 2026 19:01:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023220148.GN3977851@ziepe.ca>
References: <20261023190036.GL3977851@ziepe.ca>
 <20261023201531.GA2805244@bhelgaas>
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
In-Reply-To: <20261023201531.GA2805244@bhelgaas>

On Fri, Oct 23, 2026 at 03:15:31PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 23, 2026 at 04:00:36PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:
> > 
> > > > Yes, the ACS combination is selected to avoid ordering issues
> > > 
> > > Does a user have any way to know whether the configuration is safe?
> > 
> > No, unfortunately in PCIe so much is really difficult when it comes to
> > deployment :(
> > 
> > > I'm wondering whether users might use "pci=config_acs=" to configure
> > > ACS so things appear to work as they prefer but may not provide the
> > > ordering guarantees drivers depend on.
> > 
> > I imagine that could happen, but on most practical systems the root
> > complex will blow up if you do asymmetric routing so there is an early
> > indication.
> > 
> > I know this because I've help debug such configurations at
> > customers. Some servers helpfully MCE if you do this. Lovely.
> 
> I'm still confused about this because earlier in this thread, I
> thought Leon said you do asymmetric routing:
> 
>   Bjorn> And I guess asymmetric fabrics must mean fabrics where
>   Bjorn> Request Redirect and Completion Redirect are not set the same
>   Bjorn> way?
> 
>   Leon> Yes, in some of our systems, deviceA to deviceB is going
>   Leon> through different route than deviceB to deviceA.

Yeah, that's what I clarifed, it isn't quite accurate. The asymetric
routing is between Strict Order and Relaxed Order TLPs, not
request/response.

Jason
