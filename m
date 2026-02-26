Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C8285CB4
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145663; cv=none; b=pLcsE0VZss4r7YeVluxVXIYDjXku/aCteC+HG4ojmEb04y4hBPJx7NLnIudZCmhQr/tjo9oRnFHJR+KOKRRKAJZaZ645xM2df/iDcBY+1gF0SoShch8yp0tXMNeuK8MgaTGwMhj6kFq9F04Dg56/w1s5KJQ2VvPa0EcqrHfstVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145663; c=relaxed/simple;
	bh=dRi3trsb+BSMApQTcpWxn3KNAsk+VHHD+j9YimTpJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKRqG4dx5ELzMK1JzF4ZAwSczi6cF6VW57oFsI5Eyqciul4Madac/Q8igadSvI/ycmmUQn9MLdR5TlSvos/FnD+9HDLTiJy0t/Wga6cTfNmXvdE4V/Q4CjRQsWhg2WU+wPhUkZp1FFYSG+6p1aj1gqVbcF7LaftvOulFsWPOSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak538UVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak538UVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB4FC116C6;
	Thu, 26 Feb 2026 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772145663;
	bh=dRi3trsb+BSMApQTcpWxn3KNAsk+VHHD+j9YimTpJF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak538UVM63DnYLb7a5UhWwWgtaq8VishVOj9Z58DSnWmJPhl2/BBS526ZjYN2iSiT
	 Rah2e+ftXELud7ha8Wn69SnKAHIw1x4P+DccvNT6jUJoHm2CHidqzto+4gmd0EptEy
	 AgpOt8YzAIoESWhp3HNn/Xuct3UnI0JFwi5cbGPjVm28eSpfJI5QTmCUg0HscuK/LO
	 NT+6fZO9oSqA9kuA1Cif0EBCmKfXsWjJ7tHgzEbf8CWAWhCbDniqJUT6lp+aNbsXDW
	 hZlSjRUtHKzih38aJD9ushwQKPYwjIWYezUjMiKoLqLVTjf6FRirnzRPiXWUEgWmMt
	 1LIiTnBqzyIUg==
Date: Thu, 26 Feb 2026 15:41:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, dan.j.williams@intel.com,
	alex@shazbot.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv5 0/3] pci slot reset handling fixes
Message-ID: <aaDL_cY4oDfRsFU2@kbusch-mbp>
References: <20260217160836.2709885-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217160836.2709885-1-kbusch@meta.com>

Hi Bjorn,

It's pretty quiet on this version. Can we consider this one for
inclusion?

Thanks
