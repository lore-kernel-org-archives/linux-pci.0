Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC06374E71;
	Wed,  1 Jul 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924922; cv=none; b=p2OsK1d02earUAANC4DKsjHu/6Th3ZnDhqwYfVyxpXpCglhCp3GG/EmWW3pPIcILBZEPjrk0Dh29/jbYbFvythVRQ+S6L2dzXKF9e7kLpWFig7J0WtYpDAwWTlj4aRuA2PYUxjRNL9+wpJijao0WM/8I1+ELpWCc029Xn5+L8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924922; c=relaxed/simple;
	bh=wehnLxMMRrBDItrASTkvWAjFyIoEkEsvXkIvo0kbZK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbAFDN8aHw7HUQfXjbAGnmlFk4MIqR2vaVe+eAGJ3jI3N7eTXiHHI/DPKEb70ybPl6uJD9OnOGL5CMaEqxvITc/cMfu8xtESXpsN0Ki3Z95tFhyQWzbMC2x/NrP7EwvGtgvaTCF+RszXBxWguEPDLkl1cYKOgAb6/0sXEsxXPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W4bF+CtH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W4bF+CtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782924919;
	bh=wehnLxMMRrBDItrASTkvWAjFyIoEkEsvXkIvo0kbZK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W4bF+CtHxHluTYTTBazDk/DMqkyNEMzzQbbT1GEKzGnSGKRibB2FrGXCIEbMOgdOv
	 mGScluCTbecvVRpamQBfbYnQECedtOAQMZTxNBnDn7Q8J8kl4eQKuJUvyekO8kJ3yD
	 hDc/4oSePedl4M8Qgv09SBMPl3CnUaXVHC+2XHDvI6DZ9WtK0RUnHDUmahR6Tq/Bh8
	 K7SxEdTno5IXXmpATe1fwpQR4GYIjBcZGow8VptpAhFcEU0aFA1snThvMAoMwQNPGN
	 qMoq9rQsd/2vNIb/6BpF+PJKzmG0Tbf5UgoWzVOOY5OkswCsuzppganUL3Z7hXVLhS
	 53/2lM7htwJog==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4CDB17E0909;
	Wed,  1 Jul 2026 18:55:18 +0200 (CEST)
Message-ID: <9f59a89f-a58d-4151-bc7e-7e7cde8877f6@collabora.com>
Date: Wed, 1 Jul 2026 18:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8189
 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>
Cc: kernel@collabora.com, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 17:27, Louis-Alexis Eyraud wrote:
> Add compatible for MT8189 PCIe Gen3 controller, that is compatible with
> the one found MT8192.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

