Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60321248F73
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437073; cv=none; b=PNHdzweGsDy/kMZ85zYUhuWdRZzmYJEpufLhLB+4sEXXIoPMkrzHgaMveIXEGEngJ6QqgSyJuUoetWsCN/ypPit2tY2AhNIpLCoXu3UZyCpNZyCYZ/f/7+GgNeChfQNSgxllkbAkArkYZ++3wW5Wwgoe1j0DJnjVlJXYjLUpoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437073; c=relaxed/simple;
	bh=0YmJYIJK8IbVjLYR87vbyuCC4oz/uEx3rnHi2pTjRkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bd2dSaQdgUTSHwOtOsQvaexJgNeFcCvRTIHvo0QPwqYQ+d4rNQhRKPoPpSR2OSUTiUuFGHioPacI9ZcaD4zOfm90WVOIHKiJL7MJsvywrWs/T69sPSgbR+aulWAqXLiJ+3oL6Lv2KKydH+dSDO8ElGtIK7TaRjbKCAV1eRPiW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXCEp44c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXCEp44c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EADC116D0;
	Wed, 18 Feb 2026 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771437073;
	bh=0YmJYIJK8IbVjLYR87vbyuCC4oz/uEx3rnHi2pTjRkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BXCEp44ceVzXO8E/xf9Y4ghbbmpotMa9q9wk+hYqWIRpEBrtf7XgfPLoknbhXRNoR
	 45D3LYcL7ee52HSHQHnnEZySwvqXTUUkQt7eUwxdpezaSpWb97I56/zfG6zwCv5A+P
	 yTTlfzo57llD7jCU91RYVVn9pAkQUWNmBenjraLOe8B2okbPDKMZog/aV5ijMujJ0T
	 Wb6M9+y9elgqpM9MHYMOTOXo9LFp8JwzscckVLkIYacOV+N5VM4iaJd8dJTzRwm69t
	 j787WinJF+ZGXQ4dVlqjYRRuyEqQIPHQ3a+EzSnV1rrxte8KUaDJlgmYxhwm8ag4Rn
	 RPd/YkrjgFrNQ==
Date: Wed, 18 Feb 2026 11:51:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/5] Bridges without VGA support
Message-ID: <20260218175111.GA3434382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218134633.461181-1-Simon.Richter@hogyros.de>

On Wed, Feb 18, 2026 at 10:46:28PM +0900, Simon Richter wrote:
> Hi,
> 
> v2 fixes the formatting errors.

I'm not sure if you also fixed the kernel test robot warnings
(https://lore.kernel.org/all/202602180912.N7IZbIal-lkp@intel.com,
https://lore.kernel.org/all/202602181332.NDKD0g1P-lkp@intel.com).

If not, please run "git log --oneline" on these files and match the
historical style (capitalization, "()" after function names, etc).
Also applies to some commit logs.

I assume this series fixes some problem where VGA isn't enabled
correctly in some topology?  It wasn't obvious to me from the commit
logs, but it would be good to include that if so.

> This allows bridges to refuse forwarding VGA, and reports this upwards as an
> error, because we cannot set up valid decoding for the requested device in this
> case.
> 
> I think it should be fine to leave VGA forwarding enabled on lower bridges if a
> bridge closer to the root refused to enable forwarding, because no accesses can
> reach there anyway.
> 
>    Simon
> 
> Simon Richter (5):
>   vgaarb: pass vga_get errors to userspace
>   vgaarb: pass errors from pci_set_vga_state up
>   vgaarb: mark vga_get family as __must_check
>   pci: check if VGA decoding was really activated
>   pci: mark return value of pci_set_vga_state as __must_check
> 
>  drivers/pci/pci.c      |  6 ++++++
>  drivers/pci/vgaarb.c   | 20 +++++++++++++++++---
>  include/linux/pci.h    |  4 ++--
>  include/linux/vgaarb.h | 15 ++++++++-------
>  4 files changed, 33 insertions(+), 12 deletions(-)
> 
> -- 
> 2.47.3
> 
