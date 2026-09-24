Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AB4CDA3B
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292662; cv=none; b=SLuu0PBD4fhnrThQKoem1/yKSltiDTaqbFiIXairlRWlLGp2lBmg5Oi+wXBWBFjH1W6L5zWPU4JJeB6Eaprp1c9Z1kJG8c0bfpYG5Ffv45AoCPvvlOwDzg2S/SafIMi3c/kTY2pAjGxGh/TipJVkX4pkcuvGpLw/aaDNVwXUtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292662; c=relaxed/simple;
	bh=dew4FFqJYn+znPMh3WMUshAIF8jLNx5KHzgyCUnY03w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsOVhuPHsqhwDGJ7Xn6WFz9+runzE4wUF8f1lfEMn7+wndWI9Bm3BM4r2XXGvLxjYd9lSxjtv83DTG3DxDUrymCGL3AhUWMhKUBR/BRz7rnYzicMgu7fmXp96+jath9Kb48aoj5Elqy7Wmz8S2K1cMRZYr+CDsnkm/LtpWSwBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fvIfgPkR; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fvIfgPkR"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so160611eec.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790292660; x=1790897460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dew4FFqJYn+znPMh3WMUshAIF8jLNx5KHzgyCUnY03w=;
        b=fvIfgPkRO9TZz3LXFT+SEG5WJaB23RfGbZHN0IYFQeijvZXin6vGZ6uFEXLej9BcNm
         W8yYhyDPhbi94lGBUsvmzO4F6yFCn7qjyQDUnhBFk0O8mbzRgz7/kytEMyuD8oHovEZ3
         rf32UZ3mJ88EXbnUVdxKz3ax7lscVCr+URuyXyj8HbQMvOUpfwKxRRbwPit7w6CcjRvH
         5Ky9u+SYae3ydpD5RkvXZi9k4sbpkszPyny09uDFhA7qcUZC9dS53dtIWnYM1rFn1LSd
         FAZrBlwHQMa3yUtlzZlmPi/lHSmoCBHfuxwnGNO+/FGW2t6c/Tcd7kyZ++XP8PISTCzo
         s8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292660; x=1790897460;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dew4FFqJYn+znPMh3WMUshAIF8jLNx5KHzgyCUnY03w=;
        b=eha3C5rQVzV0xv5xrQpd5DKJk/8eGkcyqU42agKvain55RViqTnd5sNCSwWDJQzPXs
         Hu/Q5SZnsWnX5hylZI0BcmTROdK9ly4HbyMxyiisrIpWm8zpkkBND4higxYsdepT9UQ+
         xKzwKpoQaaH9h7mQhHHlNcBt66Nor+8rNK8+823P+APgJzrkPaaf72shlZPn3dQh21n4
         FpK0ewFqblnol0tiD6vH4Y/RiiBzGB3z41vkEPWe73imdD6k7WWznsfFLE0wjhGN8scQ
         MlU5HrJzua8MBPw4SGcSStIRHlaQQUy4YZfBHQRQFM0ONgfCdLT6icVdcK3Xg86nspo6
         Uqgg==
X-Forwarded-Encrypted: i=1; AKwUvBy+5COcT2CxPmkEmgEvAvhIl9kbtcgvdF8rf2zqKyqU6f2LkuLlvEmMigJSUBE2DqRxUvu1CH6FdeA=@vger.kernel.org
X-Gm-Message-State: AFuF++kv5QT/Wu5a/d5dGaw/RNyU2m7R+WvV1rWM6Jso5y4152OyYKxk
	gYB4ftc95oQKq+IY8XvH1kfGlUiIUxOSmN94YcsGlDKr8+QSXMF7Pc/mF2BGhVFo0+w=
X-Gm-Gg: AYBFou3E/sA7nQr3yJgWHsAhxHvHqSIl1DjMTzLLBqnU+d8CRGV9m919lHaN9i1pd98
	ZV+fitCLkeoP2+ZzCEdxt8CmUiiImbH8X7I6tSuazKNN1uL5k3RhxEjEYIJvZYj9WxYY0Y/DASZ
	qSr5TdznV1NoyTCpTV33k7VoOAVhaN28vsSBuTQJHPX8zMRAy24hOJYY2C6cVyAHXc7iG4U63kR
	3SxGLdr0Q9YG0Lj5MSewsie/nCeLI5hsdz3abhQnx9eV69W+8FHg5jwaxT1lunQdu0E24exZqbO
	oPKm63i3eNDGvTxfJhvQYyXnAdoBMgLhgSJ4CdgXAWoTnnk5ATjpIlRPMNBXSXPK8gjg9ChOmLv
	RJGaXa+SdxaimCFuOnBdJ6Xm5trXSXb9PqqBCxEq1ZXWgz4TO62CELLh1Kf0PhJ94N1erZpZn7t
	WrnKJSBYGUEHQG0nOJorbNMEQiVbY6hla4xF+rp1nvz16C
X-Received: by 2002:a05:7301:2811:b0:33e:53e7:1103 with SMTP id 5a478bee46e88-3400439a971mr3000301eec.13.1790292660260;
        Thu, 24 Sep 2026 16:31:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm2224790eec.14.2026.09.24.16.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:30:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9su2-00000000gds-1vZq;
	Thu, 24 Sep 2026 20:30:58 -0300
Date: Thu, 24 Sep 2026 20:30:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: fengchengwen <fengchengwen@huawei.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Konig <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260924233058.GA163130@ziepe.ca>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>

On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> I don't think this belongs in the importer. Every in-tree dma-buf
> caller of pci_p2pdma_distance() is the exporter, in its .attach,
> clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> habanalabs memory.c. There is no importer-side caller.

Right, and they shouldn't be doing that, but it still has to be
checked that the st is going directly to the peer device not the host
bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
indication.

I fear you will need some of Leon's series to make that happen.

So probably the proposed change to dmabuf ops is far too simple.

Jason
