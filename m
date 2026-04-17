Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1135F607
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430591; cv=none; b=D8288pWbq5Lwrqjvut8zcprMzPDXTYxVtWvuJs6Aqjq/SGP4gsqDM/FP56c+/esfFI1TYajCKYxFT6Z4TEl6b840HnMmonxUOx5X1WuehI2O4Hh/+l4W+sobdHoqYzHBLNYYizvZgPSiwOZBoF9kiEzFweSvqO055WNHHte97Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430591; c=relaxed/simple;
	bh=bph4j3Int2Y1BnzRX7Tv4lAKyfzRHnXm5XuE7fdEJtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbFxTFw3xDrpXLEwmb1fWxn7dMFBofgaCRZ9BuBX4snB4VAZun09Kv6kg2sYgybwhyPkMaoyL4VpO6DTIiODsir0/Fb76CNBhBrWFlmWxTxJnnO3HBWwkhi+LBqn4mvZ5JIai7uxZMvCsHgiMlwSAuU+w/3tGHYA+ZmsuGCPkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=I66wz3GZ; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="I66wz3GZ"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 34A952807F8; Fri, 17 Apr 2026 14:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1776430585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WENq5tvVQAOskotkUk0ifR3/NEd78cy9jrNA71IHlD4=;
	b=I66wz3GZmWqAlKdt7bnd7Nd+3lAP+bk8GWMc5EdThI2gMOHrWBHcA8t18PMilIWqpifxMP
	llb+fzaLOLFbdXaGNI/VRAgHmOmyCehDhTMUAQz3V9uxRAOAweww4DHkSERK2PeVsZsVXr
	CmIzxKeT4KHa4et4FO2dMjV+awyEsxs=
Date: Fri, 17 Apr 2026 14:56:25 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Mattias Nissler <mnissler@meta.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils v3] ls-ecaps: Decode DPC RP PIO registers
Message-ID: <mj+md-20260417.125559.94223.nikam@ucw.cz>
References: <20260417104223.3457417-1-mnissler@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417104223.3457417-1-mnissler@meta.com>

Hi!

> The RP PIO registers in the DPC extended capability contain status
> information and control bits related to how root ports handle failing
> requests.

Thanks, applied.

Could you please add a configuration space dump with this capability to
tests/?

				Martin
