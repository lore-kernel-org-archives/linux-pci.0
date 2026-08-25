Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403C3D525F;
	Tue, 25 Aug 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654868; cv=none; b=GcBIzmzwgJnHmyyRTQJIdBc8gJhJOTLb8YvVlzKgOuCMEX05g13eYptlHutreYfpS3+rBA0JJNKSMRYZX6FvUyKYTgJJlf98YTkwllsUsnSwNlbFiaPLEIhTJ8fkFiV9c0TKLqzV+Ecor+4tmolNkbFN0hen8vjJTPKNxhNrrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654868; c=relaxed/simple;
	bh=T4v9HUR4QiLyKVn0obl7xKCuLinaYa+EawIxJ1IBpOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=E5d/vREeo3yd1lNvRx9LMFpV/iQVqDt1Daikm/maYmMQThO7f1SWBdpk/2/2L9MDXDFbGsTcrj7tE8rFUX802UyDtsPhWMZcthuuutvFhUGvPC8aYt8KI+rhBRd2B8DNa1mJ6wE8k8L48twI5G5faz7S0vA1bBKaTD2kbsNp9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fEUqYYfX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fEUqYYfX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B7FD4E412E5;
	Tue, 25 Aug 2026 10:47:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F6C2604C4;
	Tue, 25 Aug 2026 10:47:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CB5A11C7A063;
	Tue, 25 Aug 2026 12:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787654863; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T4v9HUR4QiLyKVn0obl7xKCuLinaYa+EawIxJ1IBpOY=;
	b=fEUqYYfXm9oppt+jjmEP7wX9Bl8FMTarOuLGbtJQhcH9DxMNzKSD3bS2ENvxedOlsS5dgC
	do8BodixuPMNy0OPiyHr99NmlybWnQQdY0OFVtEDNi/L1aNY0pJdHJYgGPt9zg0Cvm15WP
	dfIgzyzUn1dN0DdGPK1lvafARdxcFv/+TxVbTa5fxV5M2yB0cFY+lIqsmKMsL2cJiNvo5c
	qij/Q9fxnVSaNqAkkuFYHXbYVFSjBFhw1vW6B+MSNVMTw+3hlqEJBSgtZZBtPdOUuDcWKk
	ccNLNoREBrsMqMctNYL0WuOV1GahPcnwGWJIcJ0Jx86XlaYa85wM2r/Z9DgJBQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 12:47:35 +0200
Message-Id: <DKXYRB39AH7K.3M4RSLMXADERF@bootlin.com>
Subject: Re: [PATCH 0/3] PCI: dra7xx: fix resource leaks in probe error
 paths
Cc: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Felix Gu" <ustc.gu@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Kishon
 Vijay Abraham I" <kishon@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Sekhar Nori" <nsekhar@ti.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Aug 22, 2026 at 5:07 PM CEST, Felix Gu wrote:
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

All series:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
