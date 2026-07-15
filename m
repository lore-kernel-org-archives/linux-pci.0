Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E742048C;
	Wed, 15 Jul 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121327; cv=none; b=kjDT9Ofayk/A8fDOV+DAsw9mouxin1QAFR1RhwIO1H+YlSaqFhRps+XIjz8pVUYlURSiILlXFqcHMYlHr0TQwL6PZ9K+vRPeKSiu/H5qHqMyTnIF8f48bAbbvQpJAItOUZwQXFr1gRIlDMuBcJXfI+6MCsX5rGf8V+pjNHmiPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121327; c=relaxed/simple;
	bh=2glUP3knC/CF6SP8XVDlb+DJ7gTstChwo1Bzs2KPR5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jU767G9mFrQQ5ML3kKNUD9XHnmflRmEsE/SOnxvnFB8m3MMJXJ9sC6aM/3iimxVyWiH4srgaFcF9cbZQEyKrt9nLvsYQXlQ3V4UiwUxBKosCZ3XliN21Q45gEX/P31Gu4vr2AXUbzP4J2DBWMwuOttHhztQ6PzCrjzzl0UGiqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOwNLdKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOwNLdKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904301F000E9;
	Wed, 15 Jul 2026 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784121326;
	bh=4DeSXaNxTofIURv81kLYLATjIHT5Tg6o0Xfm/3fMQpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TOwNLdKabKVy0xa1zK1yCloIo1mvONjB+E2Uu07gwdO5q1FfuvhFQGwDROwLVoTfx
	 g9F8vWub3HeMLfXBS2j1sgK+fRvfKElhU6UDSv9BfYVIAy26erRpZ876yA6xWYzajr
	 ktt4UwtRFAcDbdBSjpRafqxoLd68lgb518vi6bxbXN7FKPrgT8aL1vLnySenS1LkrL
	 4lEx7olpV9hUD5EVr6nT3PilwPv9vXF+OHj/xAmIfjIjrrd5MUaT4KjbSeqODjjYiG
	 Qb32XSj2gbtRdsvUCC5EcESMQblxRFttrp9ReMVvhKcpB634rqnuJPis+u+cy3M7SC
	 j64weKgzJ7v2g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260407130450.1489318-1-18255117159@163.com>
References: <20260407130450.1489318-1-18255117159@163.com>
Subject: Re: [PATCH v7 0/3] PCI: Refactor PCIe speed validation and
 conversion functions
Message-Id: <178412132320.142387.10139960720570684973.b4-ty@b4>
Date: Wed, 15 Jul 2026 15:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 07 Apr 2026 21:04:47 +0800, Hans Zhang wrote:
> This series refactors PCIe speed validation and conversion logic to
> shared functions in the public header, eliminating code duplication
> and ensuring consistency across drivers.

Applied, thanks!

[1/3] PCI: Add public pcie_valid_speed() for shared validation
      commit: e1c1eb1d8912bd209845f1e7fc99925412fc5af8
[2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
      commit: a03c77abaa802433210f193617000a3c1edd20be
[3/3] PCI: dwc: Use common speed conversion function
      commit: 6fc5fcd8ec1bdba3123b8a662410cf70bffc40f0

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


