Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB54963B5;
	Tue,  5 May 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000079; cv=none; b=cCaRdYlAsgyC2sVmIUBxyZ55de66yZXVfeUIFxYHKz14UbqKmjzyFaVh0ic9/Xxq2WBzTgjuzJp1rPQnlZR3aXtVrPKLvM6eFtYAvtceSd9mn3HznpsZm7kbvtjIYXIhnjJTdN6VFlBER0jlnlrNaMZi2I8suhU9EnPt4Sb6qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000079; c=relaxed/simple;
	bh=fxg60DBRC7ewP16U58hh90AF8Q8nkPZgxJLVWalk6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QpUNuMJlYkt4uqMdoLbw0P0A+K25vJCEPy4BZ6IiH74tRzEAkf4RXc/ShgaETYE60hWuEU2KmUK7X+DuVocp/f3FQ8tjfCTppT6Bz0M3Sv9ex8WXtFO5MuqqE9xPrUBDKN+0+eKNp8LaQG+t/TU0X4n0sC9S9nrG+1+7BgooCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkMVIJVI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkMVIJVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469A8C2BCB4;
	Tue,  5 May 2026 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778000078;
	bh=fxg60DBRC7ewP16U58hh90AF8Q8nkPZgxJLVWalk6uQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QkMVIJVIE8DTY2CJJpwYgdgcLHvQ4ayMpY0Z+nD+FB0TWgHgSv7VjMQCW7Za2o2Tl
	 BnCd/L+CJlhztiA8vuHYTjGGG5u+Sf+tCcrV/8yq09RJcvzqVPqI3e5VYNNjcYuV0e
	 iHRUSGaiDInBpGAqV9bj55w/XnhTq86wy6XjGfAWRfxP9PYZ4hxbKuHJvxBOrvx7zq
	 do7qYss0bOfRmGANaysERE9CQ5apY3QrVgYQ1FKwQUQ4Qk7pUwH0gBYyap3t7xsY6i
	 ds9IpgbF2FsVhjsDWu3oGbBIWLb0N2wmIkEX7Ut87c2L/mhoMT0ONv/sdvIQrajyEI
	 oKOdxokyoO6+w==
Date: Tue, 5 May 2026 11:54:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org, s32@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 00/16] PCI: Use FIELD_MODIFY() to simplify
 bitfield operations
Message-ID: <20260505165436.GA737933@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>

On Fri, May 01, 2026 at 12:24:04AM +0800, Hans Zhang wrote:
> Replace open-coded bitmask clear + FIELD_PREP() sequences with the
> dedicated FIELD_MODIFY() macro.  FIELD_MODIFY() performs the same
> operation but is shorter, less error-prone, and includes compile-time
> checks to prevent field overflow.
> 
> This series touches the PCI core, PCIe extended capabilities (PTM, IDE,
> TPH, MSI, REBAR, IOV, CardBus), and several DesignWare-based and
> other PCI host controllers.  No functional change is intended.
> 
> The patches are split per subsystem or per driver to ease review:
> ---
> Hi, If the Maintainers think it's not necessary, please ignore it.
> ---
> 
> Hans Zhang (16):
>   PCI: Use FIELD_MODIFY()
>   PCI/PTM: Use FIELD_MODIFY()
>   PCI/IDE: Use FIELD_MODIFY()
>   PCI/IOV: Use FIELD_MODIFY()
>   PCI/TPH: Use FIELD_MODIFY()
>   PCI/MSI: Use FIELD_MODIFY()
>   PCI/REBAR: Use FIELD_MODIFY()
>   PCI/CARDBUS: Use FIELD_MODIFY()
>   PCI: al: Use FIELD_MODIFY()
>   PCI: eswin: Use FIELD_MODIFY()
>   PCI: s32g: Use FIELD_MODIFY()
>   PCI: tegra194: Use FIELD_MODIFY()
>   PCI: qcom: Use FIELD_MODIFY()
>   PCI: dwc: Use FIELD_MODIFY()
>   PCI: mvebu: Use FIELD_MODIFY()
>   PCI: mediatek-gen3: Use FIELD_MODIFY()
> 
>  drivers/pci/controller/dwc/pcie-al.c          | 12 ++----
>  .../controller/dwc/pcie-designware-debugfs.c  | 23 ++++-------
>  .../pci/controller/dwc/pcie-designware-ep.c   |  3 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  3 +-
>  drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  3 +-
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  8 ++--
>  drivers/pci/controller/pci-mvebu.c            |  3 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c   |  3 +-
>  drivers/pci/ide.c                             |  6 +--
>  drivers/pci/iov.c                             |  3 +-
>  drivers/pci/msi/msi.c                         | 11 ++---
>  drivers/pci/pci.c                             |  3 +-
>  drivers/pci/pcie/ptm.c                        |  3 +-
>  drivers/pci/rebar.c                           |  6 +--
>  drivers/pci/setup-cardbus.c                   |  3 +-
>  drivers/pci/tph.c                             | 10 ++---
>  19 files changed, 51 insertions(+), 101 deletions(-)

I squashed these together since they're all doing exactly the same
thing and applied to pci/misc for v7.2, thanks!  I think this makes it
noticeably easier to read, especially in the cases where we update
several register fields at once.

Sashiko noticed the dev->sriov->barsz[] array bounds issue, which is
mostly addressed by another pending patch: https://patch.msgid.link/44a4ae53ec2825816b816c85cd378430d9a95cc6.1776429882.git.mnencia@kcore.it

Sashiko also flagged a potential pcie-mediatek-gen3.c issue related to
checking the return from pci_runtime_get_sync(), but that has nothing
to do with this patch, so I'll just forward that to the Mediatek
folks.

https://sashiko.dev/#/patchset/20260430162420.42839-1-18255117159%40163.com
