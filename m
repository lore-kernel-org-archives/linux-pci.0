Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849037AA82
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706883; cv=none; b=PtS3gbPEZazLIJfyamZqiud+7scyS9SqlELPfeS0ZNb1Y9aE6r2eVGE/pIiIkBpvL+1OfXD5GLD+cTwFfiBQMjFuPphDw355J0zY9tZyeP9qvtrWfmeVkq+kdkEjbWjGmX6dytoffdct4ftrvtEJIm1C5TCBZiT5Va0evQMCgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706883; c=relaxed/simple;
	bh=uikNVwpdRl5MgPRmRqyQHf4XJOwVmAVtO//+HU23/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3qtdpFJTmCkDcoRe8OHYK1NVc2P51yh8EJv+BBMp741hP+dlMW7Nzm1fuANQSZZ4XKF5Gcg2v7KwtiXBzCNXg48aziuki1uBMi7I0Upm96NwwjBReYlyn813okX8ldv6zaDoI62DwDqE3ZIXkXiMcnjaOg2DnlMpjV/DFvivJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=mxq6XqGK; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="mxq6XqGK"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id F307B2801A1; Mon, 20 Apr 2026 19:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1776706870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGmIDTY5Rv9toLUVB+bfb528Phg7gMkkbO7dOns8jU4=;
	b=mxq6XqGKHsxFtiq9hLU09xsYGpDbg7KrJxeHsj0vbN1oqgOyRslAalnNBHMQ/Y/5AH40+o
	0SQmfK4W9TY1jmnfteMoeiY50QWMFrAUa3EsaHrDmJueIDjXmr3L5DK52zXM+bZ4qk+ICq
	hwXAuH5G9wENBcSLC4i1RtrCe6Yv9go=
Date: Mon, 20 Apr 2026 19:41:10 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Mattias Nissler <mnissler@meta.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] [pciutils] Update DPC tests/cap-dpc
Message-ID: <mj+md-20260420.174101.62521.nikam@ucw.cz>
References: <20260420152529.687075-1-mnissler@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420152529.687075-1-mnissler@meta.com>

Hello!

> This adds an ECAM dump from an AMD Bergamo root port that contains
> exemplary DPC RP PIO register contents. Note that I chose to replace the
> existing file rather than adding a new one. This is because the hex dump
> in the existing file didn't include ECAM data at all, so it wasn't
> actually useful to verify DPC decoding behavior.

Thanks, applied.

				Martin
