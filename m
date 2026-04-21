Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141629CB24;
	Tue, 21 Apr 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809996; cv=none; b=iwW+m10iFgL4Tenb7ii+XYGSNRoJRSxuZ3qwXnHLlULxbEq8rPJkrlKehY1y1bOlEij3MyAOg0ET9aStyv+PTnxkMAk5089x+iIk3c7amrBpNOMKvJ+fFq6L6c1kzf/2Lgi6g2JDi83QpiAG+k/TdBPnZ7rto/uc462zvjoc+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809996; c=relaxed/simple;
	bh=D9gkMb8nHZ4E9a7ng1Zp/07VVZDP3sYFH8hxMk6N/LQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z6Sq8IQqrsJ7kd0d/TDDDbkvEc1DRXIl70a4juuzQjQOXo0wVxtdUywwZFXSoWDdYHN7RqQuSz9lJ3dvV1U14xrgP6NIhtAT7PCkipT4X9sxhxMSX2Bexwt0kC7Gx/89iMzMzSOrgE6gEDw467bZBTmEGZXklEB+I+V+uTK2ujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvX8b5zG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvX8b5zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFE1C2BCB0;
	Tue, 21 Apr 2026 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776809996;
	bh=D9gkMb8nHZ4E9a7ng1Zp/07VVZDP3sYFH8hxMk6N/LQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MvX8b5zGWQWDpexNKc352wqoED/MYDYUG3z62xZ74qYB4wpd2uGFKtOXYyF97sDON
	 MN/SafxHCzUZlM9I7Mo2SAY6DmKeEbSB0SR8Sazay8XUWzqpyHcXl4nNlKMH9eW8wJ
	 36Rk4A1fszFitehe86pH+Azg1+7XEMBB1MqxXWszp/FWvHMTnNqB6l0TnCaxCQ9Hlq
	 LFxCxBGllc474e2k9e1J0UJpAewGjojEmXaydK7qM/Dip6h3N2y+PjTXbfnok8XCFE
	 +Y2olV55YGYMFPAZgnHJdMxECBAMt2r1uwnAHY5w4O8we9BrIOIlM7rDsNcnzM7Z6l
	 N241tAUXh/eyQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id ADEC3F40068;
	Tue, 21 Apr 2026 18:19:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 21 Apr 2026 18:19:54 -0400
X-ME-Sender: <xms:CvjnaXRSUUHSGc4FLrv-mtHxWfw5iPZYabZI7mNuB6Zo7UtL-R_GJA>
    <xme:CvjnaaLqvtyql98zQcI8MsuA0AK1YqNQ_rJysrD_DwM7hZfhbhz0IpjlCUhHiviD1
    4_drmW0W0Pp_mNJLl3Neez04FPN-rSQjSnvbOUmTyl7W838wt7L_wQ>
X-ME-Received: <xmr:CvjnaWEyJulluK7bZEaine0KJyYGz9Rs6r9PTATzdSe6WhQrXqLJGZAyNExFjuRlBYmmOhVwHXrXHeKyaCQftoobJsHWO9A8_rc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihi
    lhhunhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    phgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgt
    phhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegsrg
    holhhurdhluheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihihhluhhn
    rdiguhesihhnthgvlhdrtghomhdprhgtphhtthhopeiihhgvnhiihhhonhhgrdguuhgrnh
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:CvjnafRP6Slm9m7BZqnEv9d8N8AWirav-f5XDyfvThuLepQgJo8x8g>
    <xmx:CvjnaXVMwtjsmNoXt_FsvId_a0jXpfKQm0pEIk-xBmtHjC5yoZpAUg>
    <xmx:CvjnaWgJK-J6JN0mgRrzPaD8aa2DqHUns89YMoD4CuHlZyQ5TT6tHA>
    <xmx:CvjnaYfDlYTNKIaMY6Ogpo9G2oRl9KOLnIi5svFbni3HQNwJPSXU4w>
    <xmx:CvjnaZfCmXiMGGjYmgqfRt1kVOrJ3wkk_WWAp6GWWpfhcWoWZMDkki_J>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 18:19:53 -0400 (EDT)
Date: Tue, 21 Apr 2026 15:19:52 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
 x86@kernel.org
Cc: chao.gao@intel.com, 
 dave.jiang@intel.com, 
 baolu.lu@linux.intel.com, 
 yilun.xu@linux.intel.com, 
 yilun.xu@intel.com, 
 zhenzhong.duan@intel.com, 
 kvm@vger.kernel.org, 
 rick.p.edgecombe@intel.com, 
 dave.hansen@linux.intel.com, 
 kas@kernel.org, 
 xiaoyao.li@intel.com, 
 vishal.l.verma@intel.com, 
 linux-kernel@vger.kernel.org
Message-ID: <69e7f808e9aa5_fe0831004@djbw-dev.notmuch>
In-Reply-To: <20260327160132.2946114-7-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-7-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> Add reading of the global metadata for TDX Module Extensions & TDX
> Connect. Add them in a batch as TDX Connect is currently the only user
> of TDX Module Extensions and no way to initialize TDX Module Extensions
> without firstly enabling TDX Connect.
> 
> TDX Module Extensions & TDX Connect are optional features enumerated by
> TDX_FEATURES0. Check the TDX_FEATURES0 before reading these metadata to
> avoid failing the whole TDX initialization.

I think it is important to distinguish "optional" module features vs
required Linux features. Linux requires all features that a module
advertises to succeed at core TDX init time.

Otherwise, this looks ok / consistent with other metadata reading. It 
sets the precedent that if TDX Connect is advertised it must succeed all
core initialization.
