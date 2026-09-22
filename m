Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F039A806
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059114; cv=none; b=bOFvD1PyqqUBYClpJljjQuj80KC9r5DfqStfD9N+SZK0HohJBEhBD69YzkYlp1x5JKY+G+snU7IqkDcphRgMWW6WffKXGdaGwfKlWg5Hp8r2QQ0XtuqaO+n4EqcWPm63p6+2W/YYuZSYoavXZXG0JZJngfpeOuN/5tK4N1pZKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059114; c=relaxed/simple;
	bh=B3TmqpiaHL4WRMYGGtlEFLXTSY7U0xMIAUehY213GSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOUcGkR3rq2iS9yYyv5b6r9us/qutnLpeProoeP+oDWBy1GxPW/OCGLN+cOjbXlsVM2vqWUxSW8QQ8AH+otskn1cNFYOuPd3pe/01YQnXPLwW+f2uyMfvpvmLjLJyUTwKouFjwKs56Jxxfprn0ycn/z7t8ehQ0jD4I1uqXe4eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZDso4XA; arc=none smtp.client-ip=91.218.175.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZDso4XA"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B3TmqpiaHL4WRMYGGtlEFLXTSY7U0xMIAUehY213GSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790059111; v=1; x=1790663911;
 b=lZDso4XALOqRkrNzn2h3T17gNsjtm7pW54UadFmevsZGp7gif8ugVEIx67BSgBf2qo7DKBA+
 kKETJnNRUBf2EaujngFgG5oSsz2FEZzPdhzxsnMV73Xpn57d1hvbsHnH7/FQR0nNoWgUhBlVHKO
 8Wsqgf4ZY7X7UBZrWCIgpE7k=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e38c057ce35e214;
	Tue, 22 Sep 2026 06:38:30 +0000
X-Mizu-Trace-ID: 9e38c057ce35e214
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()
Date: Tue, 22 Sep 2026 07:38:30 +0100
Message-Id: <20260922063830.472642-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <95685b0e-21dd-4446-8fef-c5664cea4057@mailbox.org>
References: <20260918091052.2825315-1-fuad.tabba@linux.dev> <95685b0e-21dd-4446-8fef-c5664cea4057@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marek,

On Mon, 21 Sep 2026 22:47:30 +0200, Marek Vasut <marek.vasut@mailbox.org> wrote:

[...]

> I think you have to call of_node_put() on msi_node(), so what about this 
> instead ?

The __free(device_node) is that call: it puts msi_node on every return from the function, the success path included, so no goto is needed. It's the same scoped cleanup pci-imx6.c and pcie-rzg3s-host.c use for their device_node lookups.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 

[...]

> "
> 
> Also, I think drivers/pci/controller/pcie-iproc.c 
> iproc_pcie_msi_enable() needs similar fix ?

I don't think so: iproc_pcie_msi_enable() already puts the node at out_put_node, on the steer failure and the success paths alike.

Cheers,
/fuad
