Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6D3D813B
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559208; cv=none; b=G6B5DiFhHF1hLElREHOJ2457itk3HqwymQjzCKfNGiXS8Gghf0QjR7dlfJHaIobWwayjrCorDOuTa1NCe2LyrZxcA/Co77g9dHr8vn9ZsU1EN2Xwqz5yvzk4rhCVSTvXAReYIdgn1oJed563Bj01h4LKlNgn7+dO8PeMUwRhlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559208; c=relaxed/simple;
	bh=+wI5T7+8Eq4IaStj6fykR+AmrBP81Mx6sQvzaN4XlNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce2y4De07nnTySk6HCbyXNvl9j35/eYj/q0C9751pcy6dyrGRb4fDX2Bny/5E8gGoMeSRB5QqrTNL808iWJ998htzNnqOh1Abf6adeKxq2P9iByMnd6505/TEWcWQdZFzb2Iu5rkwXRqMuh+12VCeMEgGSe2Vfrmd2qVVrpTROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1FAF8B82;
	Thu, 04 Jun 2026 09:46:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E179D602E11B; Thu,  4 Jun 2026 09:46:36 +0200 (CEST)
Date: Thu, 4 Jun 2026 09:46:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Message-ID: <aiEtXMliRkz3jORI@wunner.de>
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
 <afuAjeWepSkzO12O@wunner.de>
 <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>
 <afwUkP1P-HNfMulV@wunner.de>
 <8a7cf3f6-07e4-4d12-a2ac-72de02a03eb9@amd.com>
 <43545019-221c-45af-b646-3b3d4ea86718@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43545019-221c-45af-b646-3b3d4ea86718@kernel.org>

On Wed, Jun 03, 2026 at 02:04:33PM -0500, Mario Limonciello wrote:
> I'm happy to share that we figured out why it was only happening on Linux by
> comparing the traces.  The USB4 CM on Windows issues issues a downstream
> port reset during the tear down process.  This is missing from Linux.

Thank you, good work!
