Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC73C8C68;
	Sat, 17 Oct 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258423; cv=none; b=NTH3jlcVxwcV+wkUgH4/mps9O/UJY8F3ov93Wzf4mp03LVmmHo6ZnMU9N9hbromSbNhqCyfUOs9DZcfAV377ota2r6yGL0tX+HnlAwif1/f8bq8jOMnsSNmEX9ARgdslBzXdAHd2aqKhVDrBwdrWzlTKupxz2UG2R/wOFm8MNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258423; c=relaxed/simple;
	bh=9an8ZU9aL8kZNakcS/RYNxKgIe8hkwL7Sx9YGGe23ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flXXwtJgevTyMHrFR+1le9PQRYV8LZbme6tMBiEk/JDTCyrNPGtYUgsermAgmjHHCQmPeaNreoVOQr0PNO1uzizzTb+DMXb534K+D8XQ+eUjF5nLllZGbmEH3LF5AF20NgSPCOJMHu5h2hVMJ3gXfIucITTcZb4oyeS47cw50M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iuEZsMQo; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iuEZsMQo"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j6TS1710yzMlJf;
	Sat, 17 Oct 2026 19:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKbV9Avda/1koykeC8dCH8WTScrt3Q+IRecabZtWXo4=;
	b=iuEZsMQolC3p4GIh0BUNGRoU8wytxR07GsaUGG5hdPQPbdsshRBwwzhGKyfwoTpH6N6zTe
	T23LOUReU/gvtKNLkhGhQEIin+YaX9QZrkSwNmWR564TM7yin2k6dsy995+52TJOhiWEqa
	nQw9Fs6dWaRN4rU2vIHimiIbFZbu2rMSXgOeKwF97kciLpj7XlxG/J3dZmP+gYxBGj3eDg
	qTyXiE9UqST9caf6/f4w/2JCL2ApTl+mCGd+JF3F2oICsJgotQOblGsWI5BUzXzdU/h3RE
	nywaAW0TMYXR7vwgxaU6JBouGfREI3fRODpaR07BSswrsLlKDSLaJ6V8XQKssA==
Message-ID: <ce856844-573b-45be-82eb-cda58dd5ca9e@mailbox.org>
Date: Sat, 17 Oct 2026 15:24:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] arm64: dts: renesas: r8a779h0: Describe the PCIe
 AER interrupt
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-19-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-19-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5619af8c79a4a6ac0b1
X-MBO-RS-META: cpf1tooqt7aunik7ui1y1pkhch8s1gt5

On 10/15/26 5:31 AM, Koichiro Den wrote:
> The PCIe controller reports Root Port AER notifications through SPI 454,
> separately from the integrated MSI receiver interrupt. Describe this
> interrupt with the "aer" name so the controller driver can use it for
> Root Port error reporting.
> 
> Append the new interrupt to preserve the existing interrupt indices.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
