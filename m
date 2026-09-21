Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3949E139
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997164; cv=none; b=pqC2ClacRMPgk1KoaflzY/RESgB2IcqZDSgPWspRmS5RTJ0mJO3jVAIbvC9cTYwxRW5xlbw0SLWiL/wJqrj5cNTzf5w/H5j/MHPyLJizw1RzkL1SRYIH1cNhpxGda0l0s2hoTHHMjsGTO9039fADzTJkRMcx/pZOnAEV0W844g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997164; c=relaxed/simple;
	bh=jI7O6dwFsIzcl16MuxgQK+8Hj3EPC7adm8Q/IYAxJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkSR1HuHgGk17XqvkFKLyc7VWQ8MqEfjImfAIdbVFY+dHWxQzumivx9a5qpZUb1I27TDC4h4DuQXwNcvwPi/fU6Z2oPAd1O/sat1VadROaXElDpU65CtI7qVtAxLdjMtiVo1Qw49aNf5n6uIH3DEMUrAUL3/xcqCtpQV+GRdZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qn8N0JVJ; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qn8N0JVJ"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9833bd5daffso624259241.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789997160; x=1790601960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
        b=Qn8N0JVJyO5GjQxFLgZn1BQqq+hEFnpT4XTo2OP6jStKvSzF/fmEKMPfM9sMX8+JG+
         3a30NIR53CWkQV3oQlyWGEU8Xgf9IXRNTu27Vix0Sm3zXX6FqQYMeNVQMHEJnCB2Z7z5
         rppPhTnNjirk/bWXGQ5yjO7HqIBbZ65RLmAA/gWHlS3LOBzSPgvhveDnqZZG2XljQMDE
         WUrgH3IuEhYn8NcQP/n15qAYxBvwpCvUnH21hNcXB7QJQhsoFgQC1rOPq68W59e6LvUS
         PccoFlPN6+HD+8fk8JoOpL/YLv1+VO3fqF4wmCirNKyrso1CIamiv0t3XaofZ1M5+VmB
         zVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997160; x=1790601960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
        b=Cy659mfw/YBB+OJMwzSNHdAxWUgavJz9y9pxhq7eWZu2Hv1HF62uutu86ecuKY8Th3
         H/BL3PiYlOMCNofmeuhCuk2S2mQ1M/mIyKa6FU4iAyfHZlgQHK9x/01h9dWOlYD/L+r2
         PPGDsrLnHV1H89HhyirrFcfqdcpRk1p8gdvH/tpfxLSgu475KIVmM3Y/BnyqhLgShRYc
         qiXg48V1zbYK1nANJOwzx+8euaiDZr0R7aw8ydGmGwpT/yAEeV2dDxBzkBPb46f2zcgH
         n5iq6ye2ALJo2H2Gb96CbigvjKtVPX2Ji1vCW8LixF+m7QqKevnUZ3EkQoR9fk+Tu5rE
         laRw==
X-Forwarded-Encrypted: i=1; AKwUvBxiOFGnDuVDE6jYKdkOgBzjFswSwXa0wJQqj+CHTwBlG4sXYy2dDXU+Kkq3StkjncWxIbr4Nx1LI7k=@vger.kernel.org
X-Gm-Message-State: AFuF++kFOFT9VU7LWN5nL8j8AD1//qc+RWar6Qpil+4W4SrxCve00D2m
	2QHUnw4sHFQAyI5zaIQ7BUs1qiFksRFzx/s5fPRPR8pAx76I+Ul/ChUsGgGgv2G3IVA=
X-Gm-Gg: AYBFou23ZOhuKlBHi+GpyKFQuX/N3qktHBj4OzOwqicHnw5t94nKR9eXjaJJ1PuphqW
	RbWn8ZaoB/189LqvKDFbQEH2LOjKiAkg+bLH1AMgwrTRqQ13fsVAS0k+cUJ3OERU26Evr4jsFuW
	oCMfUw4JCBXe+TzWhA6on9cuEzVgIrOtfiVBVyfRzVRSxAyC37/h/VAEbRuNlOnsttAEOBVzKNB
	S9v/02vD9qm/Hb+9MtZY3/W2eKsl9i4oXo3jbYXDUEkgX9ej0ekvl9bwmyx2fAriMkwMPjfI7F0
	yfTbWa6A1x4A5iafMqDzT/fbLxxoTmF+FHv1BnMnMn1Yv+Ala8WYzUtDOAnEE8D39EkQ4ZyFGKn
	L3xQDDneaT/D5+ylDHT+Yx4PSIZC/0Uc9EKEZbRAqPfW3nMg+wOWDHK1z43qG0uEOd0TPmcNS1c
	qKiyE1HEi7w2mewC/trqT20Mm3qCtO7xOLLaYNSlegYX5Xqny0jDrbRPmhY8B0mF/4J+LBuE+ZW
	lFoALfg/3w6A8RWop+LJrhfw/c0LqH4bXiX62yZw+xbJg7XB/qq/NR6
X-Received: by 2002:a05:6122:209e:b0:5c9:a491:641a with SMTP id 71dfb90a1353d-5c9b8a6c1afmr4625797e0c.4.1789997160437;
        Mon, 21 Sep 2026 06:26:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a60f21sm67324286d6.19.2026.09.21.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:25:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8e1v-00000006Knm-1R2E;
	Mon, 21 Sep 2026 10:25:59 -0300
Date: Mon, 21 Sep 2026 10:25:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260921132559.GQ11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918121500.GV13683@unreal>

On Fri, Sep 18, 2026 at 03:15:00PM +0300, Leon Romanovsky wrote:
> > That is, a flag to tell the topology check that some transactions
> > *will* take the host-bridge path due to IOVA being used, and that the
> > computations including pci_p2pdma_distance() need to check whether that
> > is possible (checking whitelist etc.) and return the corresponding
> > THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> > cut using the bus-address would then be hidden from the driver.
> 
> The word *will* puzzles me. As I understand it, if your device has ATS
> enabled all the time, it should always get THRU_HOST_BRIDGE.

The P2P subsystem currently does not understand ATS, it assumes the
device will use untranslated requests and makes the routing
calculation accordingly.

If the device knows it will use ATS it should ask P2P for an ATS path,
and P2P should only return THRU_HOST_BRIDGE or failure.

The purpose of involving the P2P subsystem is to verify that the ACS
flags for the ATS translated path are going to work. There are many ACS
configurations where the fabric will hang :(

For something like mlx5 it is ideal if P2P chooses between ATS or !ATS
based on what provides an optimal transfer. eg there is usually no
reason to use ATS to access system memory for streaming (ie non cache
hitting) transfers.

Jason
