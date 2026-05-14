Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F423E1CE6;
	Thu, 14 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772294; cv=none; b=IVNAcWNuHuAAX/sPZnw6/OxJxDy/ODGxa7p6O6BqNCFkzAlpmEHv5uY/lBMLBi/NFKEOIWo7J002wS1swh5LsTOnSoYulq8HKelBm+/DkHfuO8WNFZTcxntAxAEOfCci/CEBf8pdvlQlS5afHwV5H91MyfIzU8/rwWWHS2D+VN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772294; c=relaxed/simple;
	bh=pp56e/DCHOxZ+Eut9lk+188HvenrbqBoOLsSg2cmQrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ie48xO3Sj9ThQNnW2lXqflut6yPWZ2Ld28F4zn7ZNjsZ6XKp6YEdJuxETfbXg4IxLTfS1tJxCYmtW/UaGmzuLonQSt6Yzwk4CVFKfmSocTX2LQ9YC0vp9vbxqqiaTmDAg5rkUMjGRu4kGt00SwoE0DUVy040KoLAHvXCsHNMW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7CpSyu+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7CpSyu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A92DC2BCB3;
	Thu, 14 May 2026 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778772294;
	bh=pp56e/DCHOxZ+Eut9lk+188HvenrbqBoOLsSg2cmQrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I7CpSyu+P0Xv1f+CwVAtXHqRkk2+3kFBG1SJBrfAI4kfjGfXc0ZsrbSOdmQaoRfIf
	 8XA+X02uEBJTAtt85EtEM1LP7exZNpI46fEhlfsFlbhxKP57S5AO+yHTHn6EM9XTTF
	 xeffW52S7EUxnBn2bLlQvLYkCSalCLmKdOOgVI6nVJ0Ft8H7xq0eq0fotAQbr3r2l2
	 QyTkHkLoqw/l2Sly+MXmK1JxNcCtWWhMrX15qzkPJ022tHz5pC2n8DJ+Aq9aZ8CDmh
	 QK/1gbinOmpMPrPyaHwXyyfaQm9G9/sqjtmARkjbuFTXpefsA3ctOPOY406Vdx5L0Z
	 S3+DSW+jrw8ZA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Vipin Sharma <vipinsh@google.com>,  David Matlack <dmatlack@google.com>,
  kvm@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-pci@vger.kernel.org,  ajayachandra@nvidia.com,  alex@shazbot.org,
  amastro@fb.com,  ankita@nvidia.com,  apopple@nvidia.com,
  chrisl@kernel.org,  corbet@lwn.net,  graf@amazon.com,
  jacob.pan@linux.microsoft.com,  jgg@nvidia.com,  jgg@ziepe.ca,
  jrhilke@google.com,  julianr@linux.ibm.com,  kevin.tian@intel.com,
  leon@kernel.org,  leonro@nvidia.com,  lukas@wunner.de,
  michal.winiarski@intel.com,  parav@nvidia.com,
  pasha.tatashin@soleen.com,  praan@google.com,  pratyush@kernel.org,
  rananta@google.com,  rientjes@google.com,  rodrigo.vivi@intel.com,
  rppt@kernel.org,  saeedm@nvidia.com,  skhan@linuxfoundation.org,
  vivek.kasireddy@intel.com,  witu@nvidia.com,  yanjun.zhu@linux.dev,
  yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files
 across Live Update
In-Reply-To: <agT9bYpXskVwW0E_@google.com> (Samiullah Khawaja's message of
	"Wed, 13 May 2026 22:42:56 +0000")
References: <20260511234802.2280368-1-vipinsh@google.com>
	<20260511234802.2280368-3-vipinsh@google.com>
	<CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
	<20260512211412.GA2819150.vipinsh@google.com>
	<agT9bYpXskVwW0E_@google.com>
Date: Thu, 14 May 2026 17:24:46 +0200
Message-ID: <2vxzcxyy9fpd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 13 2026, Samiullah Khawaja wrote:

> On Tue, May 12, 2026 at 02:29:19PM -0700, Vipin Sharma wrote:
>>On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
>>> On Mon, May 11, 2026 at 4:48=E2=80=AFPM Vipin Sharma <vipinsh@google.co=
m> wrote:
>>>
>>> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>>> > index c12d614fc6c4..019de053f116 100644
>>> > --- a/drivers/vfio/pci/Kconfig
>>> > +++ b/drivers/vfio/pci/Kconfig
>>> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
>>> >
>>> >  config VFIO_PCI_LIVEUPDATE
>>> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
>>> > -       depends on PCI_LIVEUPDATE
>>> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
>>> >         help
>>> >           Support for preserving devices bound to vfio-pci across a L=
ive
>>> >           Update. This option should only be enabled by developers wo=
rking on
>>> >           implementing this support. Once enough support has landed i=
n the
>>> >           kernel, this option will no longer be marked EXPERIMENTAL.
>>> >
>>> > +         Enabling this will disable support for VFIO PCI DMA buffer.
>>> > +
>>> >           If you don't know what to do here, say N.
>>> >
>>> >  endif
>>> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
>>> >           To enable s390x KVM vfio-pci extensions, say Y.
>>> >
>>> >  config VFIO_PCI_DMABUF
>>> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
>>> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFE=
R && !VFIO_PCI_LIVEUPDATE
>>>
>>> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
>>> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
>>> but what specific problem does this solve or simplify?
>>
>>I should have provided more details there.
>>
>>When device is getting reset in vfio_pci_liveupdate_freeze(), we are
>>zapping userspace mapped bars, we also need to use
>>vfio_pci_dma_buf_move() to revoke dma buffer access or
>>vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
>>which freeze already takes, and there are some refcounts which are
>>managed in both of these APIs. This was causing complexities with code
>>flow based on result of pci_load_saved_state(). All this was adding more
>>refactoring than I wanted in the series.
>
> Maybe we can return -EOPNOTSUPP if any dmabufs for this vfio cdev are
> exported during preserve?

Whichever way you go with, a TODO/comment would be nice to have so
someone (including future you) looking at this code knows why this
restriction exists.

--=20
Regards,
Pratyush Yadav
