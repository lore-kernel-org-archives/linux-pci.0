Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862227;
	b=tLVYp4INs7x7l7/XI+mY90hp0aS8agaB5XX17ofklie7avCcmta5k1fG5bZ3EfqZJ4Ru
	 PyF8LtWaVg0rHLD9W2EkF+V2+W0HsN+k1FWxEfnc0rwDKi1MPKPBpW4NROfEHTUuTrnYF
	 dEFv6agNJ5LLZ1HmAsGzRDVF1cCllB5U3SFNU1/MDhVYUZNnYmz1NuO5m5oen5syY8iNN
	 gMgacrQcRCQmGMOz47skj6OW4ntvKlBZInFoIt/kWEQdnxsObLXJWSO5wduykNEb+rGrg
	 zMl5NsZW8BqtwiJSzPKIEBuPLSVlKIZF8qp4+vsemSOXkZ3JJUZx9eAKLm1RXzdlYTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
	b=TUtMgbYFsrDaKK5VTJ69FsJTLy9SnYNamrVcRZnNkrmieI5rVNFpGFcE2EnuVdpGSuE0
	 RX2Dswy1O5vIElCxH830xeCsyFoaEhJHeLcGkPSmt7cMXnv01/se0zKGYsodYviEPYMIW
	 ZHEPEyNUoRR8jW2/wcxxqXuJ/TZqxGbp2tSA2nI8zvZdtI8S38P4eoMVKgnNsDHjRHuIj
	 XCkq3PJXf5hsdxbgQrNHzsv2W2dq3F9cXelQ+0hbWJgFWYfjO87uTa2HuFnt5frhN069R
	 IZb1BSN6Sk+F16X67Osy54Thl9x4Oi9Porr7RUXXExNB8ivKycFB88qc8d8a/5p/XQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dwg3aB5j;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BD606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 20:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dwg3aB5j
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1662168b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794862226; x=1795467026; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
        b=Dwg3aB5j/PWPJaLku3L1tUZkBCUnHRSbqBmF3A4BQGz08Tq28ncBeYQbG/So5ZsN+h
         NojTXp3MVD/ZSvcPTtCd3tmxdm9+qM5KoPTSkI+CLdlA+txelMPpn8SZybXuEjrLBIaV
         YowodJucWxxle8t1RD08hQ061mcCTFHAAfcigRC9haQR8iCHdz2xN+lplQeaY4S1h8P2
         rfyRhY/H0SQx7FRPTAB/RKZgvSK1AUAlv4LwLdvUsGDJp95HEf/Kqijr56sClMPAuG4N
         jqnkIcUVMlGE6mtQ8PhlTITjVU0VqdOlyT+0EtqE4DK5p65P3wpVCNkS6l7wiGteLlYw
         f3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862226; x=1795467026;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
        b=tWgseVJpDv8fVDUp5ueFD9ndTTVmz3HLDOrovECkzce4AaA7GOHt+CLrsGpn3SjA78
         da/rbXrlzduUpp3VnLn8lzFuxKl9febP1Lvw+8xSAkcGxoKctdHeIy4r7pQJBsOSGlNi
         MHwERwarVx4PygdBhuia1v6sgU1nfChkLbh1zyGeLdWMRuZuWv/46DWm91Rqrvj3+9lf
         sUxcLKmNAEiA44amsocGt4VTOqd//WtjcBRwGj/ZvK7/lOrCQBeZBhEsvTDNt0j0oh1l
         CEzGblnAAWIK8Ya2LannH4SP1x0FFq9cJ6sy/YS6kzrNb5RFx5ZvXMwmKIEw8M/XGazg
         SsWw==
X-Forwarded-Encrypted: i=1; AL+hErHrlUcOJjoMd8MoyiumTFWkebOkKFQsGZwHSPnVYW5x2WlyE3l7JmWIzCdLIdOcJ4U+675cIMxknPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wFK+1Uce9PBHNqLJXjDzULFWQSHQLxGYLHEBAbeegj7gd8HqN
	5Td8n8ILpib6aT00iE/C0xcS+FX9ilTvA3NHvuQrnNkcwgaxGGUvu40eYbkLEKfeqA==
X-Gm-Gg: AYBFou2vgiDssB/EOZco90kMHj+XnwEkdxjS/ab+HEVsHgV4Ai9LWcPiWA+YUCuxLmn
	Xdt1RTQ989oqMhhvKBynSWfC6Ynduba/36/CjUmsKbg74L/aouIgJQBXpZD1SwX7erBTmLZezHv
	vnFDvyeF0x1rXCO4x6esT9rmX4YEETMTYy2h8R+/x/1Cy0UWUtxj7bEb0A17C0jBB4oFKmERnAj
	1hzkL2EyH6rbkIszSCJnCbKMidsaO+/je8h/UEGEgaOF6j7kBda38U8Wf30aP56aXCvGym6Z9v5
	mdE7kE+YIsNiLVnek0m8HCZK3igU+i9oQS8FOMHFWOJUzK7sdNB8oDoWXvXoxpq9dB3TME6e5sv
	GAO4svYkEcEvW5CdqQvW/QiD7vp4n63ktUZZ38/mll0DfdJdQce8ZoCVq63KdxmVyrA5aHmSva+
	DJ/SFpInr/wXcDjjL2ctPYtJoaQSgtlKvBgZNJLlcW3MEFyZ0fxuFIKSxZb29j8QxOwK10ccfTB
	i8/jDFdq8AfqIVtOPIDueCXyjVqozv7iAdfZWdR0vf/IxQSDcgYy9lS4MTZzl/30xb4FeL8iF6n
	n2AI4rDbLp/VCLtKgwQr7ERycn9YRU/BiGvkorquyWfOGCOrQawIg1KAtfELWQmI
X-Received: by 2002:a05:6a20:ef03:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-3f7a51ba2ffmr9092719637.7.1794862225898;
        Mon, 16 Nov 2026 12:50:25 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c847asm4527944a12.28.2026.11.16.12.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 12:50:25 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 12:50:24 -0800
Message-Id: <DMWXK2VTL3XP.MWW7ZG7Z6HUF@google.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Alex Mastro" <amastro@fb.com>,
 <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Josh Hilke"
 <jrhilke@google.com>, "Kevin Tian" <kevin.tian@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Logan Gunthorpe" <logang@deltatee.com>,
 "Matt Evans" <mattev@meta.com>, "Matt Evans" <matt@ozlabs.org>, "Mina
 Almasry" <almasrymina@google.com>, "Shuah Khan" <shuah@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma" <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Samiullah Khawaja" <skhawaja@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
 <avtI--OIZu5E5sma@google.com>
In-Reply-To: <avtI--OIZu5E5sma@google.com>

On Mon Nov 16, 2026 at 10:24 AM PST, Samiullah Khawaja wrote:
> On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>>Looks like GPUs and NVMe can do both as well.
>
> AFAIU the memory BARs for GPUs would need initialization. The internal
> VRAM needs to be exposed (mapped) to the BARs.
>
> Do you think we should have a P2P device "setup" step that can be
> implemented for various types of devices?

Yes, I think we need something like that.

I've been prototyping a new optional op in struct vfio_pci_driver_ops:

  /*
   * Set up a range of device memory, accessible through a BAR,
   * that other devices can target with P2P DMA and that the CPU
   * can access through mem_bar->vaddr.
   */
  int (*mem_bar_setup)(struct vfio_pci_device *device, u64 min_size,
                       struct vfio_pci_mem_bar *mem_bar);

vfio_pci_find_mem_bar() falls back to calling it when the device does
not match any entry in mem_bar_descs[], sanity checks the returned
range, and then runs the existing memory verification on it.
mem_bar_descs[] stays around for devices like pci-testdev that need no
setup.

For NVIDIA GPUs, I had an LLM work on it and the setup was simpler than
I expected, at least on Blackwell. BAR1 comes out of reset in physical
mode, where BAR1 offset N maps directly to VRAM physical address N
without going through the GPU MMU. The LLM confirmed this on by writing
VRAM through BAR1 and reading it back through the BAR0 PRAMIN window
(and vice versa) at offsets from 256MiB up to 178GiB.

The nv_falcon implementation only has to:

  - Wait for FSP to finish booting, which takes a few seconds after the
    reset VFIO does when the device is opened.
  - Make sure BAR1 is in physical mode.
  - Return the range of BAR1 that maps VRAM (the size comes from
    NV_USABLE_FB_SIZE_IN_MB), staying clear of firmware reservations at
    either end.

With that the P2P test passes with a ConnectX-7 (mlx5 driver) as the
initiator and B200 VRAM as the target.

A couple of open questions:

 1. The prototype allows .mem_bar_setup() to be called before .init().
    That is enough for GPUs, but as Jason described, mlx5 device memory
    has to be allocated from firmware, which needs the command interface
    and therefore init(). Supporting mlx5 as a target would mean running
    .mem_bar_setup() after .init().

 2. nv_falcon does not support Falcon DMA on Blackwell yet, so a B200
    can only be a target for now. That requires a driver to be able to
    probe a device that cannot do memcpy. I am not sure I want to go
    down that road.
