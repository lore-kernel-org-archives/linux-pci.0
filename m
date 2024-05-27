Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAB38FA6
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813540; cv=none; b=fwPEOORXv+QnRbktc9PWTkDORZcycx9Y6hvAXmJ3StgbUETMXjx/rpZTyQoDL5Nyuf3TbsBRyXyOv9iGapG6J5MbGcN6KWQjn5UF0eDB/Y/nWnR8xkcwGsgOktzguBPnkPFiSALLuqKYlNQmttiRWsI0C+ptE6OGxrHKA+dzxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813540; c=relaxed/simple;
	bh=KIjIpC5rcpxLBXmzdTbEpKLEnUt5OdEokCJgvGEKjfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwQ8nDb3L5yORcWRfWSqNnN/rD5rOJY5J3DXmT7m2ZVSFYwXA5BoH+zLtuxdooYSpy5aiuPy0PqkHV8qQt9qKBAMQ3nbMd+rgtBIT79HBhqNt3ruVerqQzNoSVnjIziP/OL85CvDq0pyLqNncC8Omp3ktgNYdxTV/C1v3c2sPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=M3U8L5nE; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="M3U8L5nE"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 9AE792873A0; Mon, 27 May 2024 14:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1716813535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1PjkNKtx/v/w9TcdwIx+3dGQiINkvnRaLGvnqwYMO0=;
	b=M3U8L5nE2T1CMX03pUz0seFNu3d5HTOWfBDyzdBLCv6YoEcJRVE1IgLG47HkomIxkZD/2C
	7xyh1HjHHMPU/8YAaCLsC7enmeOx3LpCvHPSZVU9O2GguLBITuLoWD8W9RXHq9j86FIlc9
	aw29tX6SnU2XCT13QmxWE0hebMQI5yQ=
Date: Mon, 27 May 2024 14:38:55 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH pciutils] pcilmr: Fix margining for ports with Lane
 reversal
Message-ID: <mj+md-20240527.123832.16906.nikam@ucw.cz>
References: <20240522160819.30208-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522160819.30208-1-n.proshkin@yadro.com>

Hi!

> Current implementation interacts only with first Negotiated Link Width
> lanes even when Maximum Link Width for the port is bigger than that and
> Lane reversal is used. Utility in such situation may try to margin lane
> which is not used right now and erroneously fail with
> 'Error during caps reading' message. Fix that behaviour.

Sorry, this does not apply over your previous patch.

Could you re-diff it, please?

					Martin
