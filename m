Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286A1DF254
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171730; cv=none; b=RwB3eW77brm39AW8RltEdy5yh3/lReiX6B7wTwczs0QE8dS+2ETdwn+aEETkXsSqLaYXbTtW6DnK//lwletaNGV7oZr4YzANa2hU2MbtuDL+SQAAca9l1/mX7495hyZUyjREXBLuwh2XAPxeWam7duUIBIHxS9b7HxyKIks0tYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171730; c=relaxed/simple;
	bh=NPx9iUzmfbfaFnFGts8y+q3gUOSzLlHGkd3Wr0x9A70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=W3KhGpms1nAwmuwsGQx5npDUaf/6jlVk+zIv5dD16tIg5dnL51EQmnoifniDEwGxGtQWB6qgegpzlCXCZCxI2t1Fg6NDC/BAy5R+3K7Vl62hn0LsyF/i5/6uFIEJEm2IPYM2cebyxsmtErD7yP+eI2+UEtuOsZs7VLZ5bJLYtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=dbmnzrmi; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="dbmnzrmi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NPx9iUzmfbfaFnFGts8y+q3gUOSzLlHGkd3Wr0x9A70=; b=dbmnzrmiotaD+mLk6QDge0Kzp8
	ciDLbZYAUzvSRJqRBJ5mksudC1olTZy0JWHH69m2i6INLiu3UpTD9UlAc8smCfVHCRXHyI6xoLlHE
	tV5SctpNEgg9jVQ2Tpb80dMzc58voo2zBrQgob5RMTC+eC3scvRB3h8BjvzsWpkJ/aUw=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wCdOo-007jUY-2y;
	Tue, 14 Apr 2026 15:01:50 +0200
Date: Tue, 14 Apr 2026 15:01:50 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: bhelgaas@google.com
Cc: michal.winiarski@intel.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, mnencia@kcore.it
Subject: Re: [PATCH] PCI/IOV: Fix out-of-bounds access in
 sriov_restore_vf_rebar_state()
Message-ID: <ad46vozbraLMsWnj@spark.kcore.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408163922.1740497-1-mnencia@kcore.it>
References: <20260408163922.1740497-1-mnencia@kcore.it>

Gentle ping on this. It is a one-line bounds check fix for a real
UBSAN splat triggered when config space reads return 0xffffffff
(device fallen off the bus).
