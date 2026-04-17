Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7232010EE
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421204; cv=none; b=BaPcrmGJMbnCid0vUhyFT9G3Wm/6PYEkFF6Cm/lJAP1Sp16ZnN02Wr4PLMMheBjdJ2blG31DWMZWNwbDl+2tf2lTI2674Urg6ZC2rqMlV3ck73lOAhnozBr/MxncikclNshYAZihyDt3toHlevacs3LUQrkDcNk6VgPNGNwQ53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421204; c=relaxed/simple;
	bh=wVGxriPYwpEy7KDUm5xhtzV94iN1T31Pph975Plo3J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC+CU2SpIPuu5ytzTo8Ov0PIAeKd0QShTe1vRaIQJw4tkfeZ1XyDuz1i3aHkgQFOaSP7W/oS/HFwmfyb6bBbWttmvyJwnr3ViFGa2/ZQImm3uXkYn9WiPFv/vuz3dQQJB3MKEaRR6SrA+0SBi8hJUoCHS+lxOBALRSXV43Ii30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=OPlcKDu/; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="OPlcKDu/"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 191522805D4; Fri, 17 Apr 2026 12:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1776421198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdrLUT9la43oQwWwNxiSXX7ddlzx6kuA7+yNCZJ0NWE=;
	b=OPlcKDu/i+qylEAnllYPIT50CpEF68qs6W+0ZClm7UQnuvCxgLiHI8SandZqt+5NV3DN4G
	s5AAhJa80AyCdFK+tr4YhBifFapsFiWTXQgTnp/wEuY7InYfVQTyGseBR2ZWAS8QJ8lYIq
	AVxcBj8nbtCsRoeFUPoE3PjzJLKdPts=
Date: Fri, 17 Apr 2026 12:19:58 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Mattias Nissler <mnissler@meta.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils] ls-ecaps: Decode DPC RP PIO registers
Message-ID: <mj+md-20260417.095535.38120.nikam@ucw.cz>
References: <20260416125706.3875359-1-mnissler@meta.com>
 <mj+md-20260416.200014.48272.nikam@ucw.cz>
 <CADNGngY7bpBP59x9B7Ekiy4Bgbyrz4Sm-RkXPAy9FRLGpN-uTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADNGngY7bpBP59x9B7Ekiy4Bgbyrz4Sm-RkXPAy9FRLGpN-uTQ@mail.gmail.com>

Hi!

> Ack, will update.

It's better, thanks!

> Per the spec, the 4DW Header Log register is always present, and there
> is language requiring the log size field to be >= 4.

I know, but I've seen too many devices violating specs...

Generally, the pciutils try to cope with whatever incorrect data the
hardware reports. It particular, they should not crash nor get caught
in an infinite loop.

If the log size field were < 4, your code would call get_conf_long()
on a part of the configuration space that was not read by a previous
config_fetch(), which would trigger an internal error.

A simple fix is to condition printing the HeaderLog on log_size >= 4.

> Also, my understanding is that this is intentionally analogous to the
> AER Header Log register, so I took the same approach as used for that.

That's fine, but in case of the AER Header Log, the config_fetch()
has a fixed size, which always covers the log entries.

				Have a nice day
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
