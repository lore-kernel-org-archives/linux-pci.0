Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD84C954F;
	Wed, 22 Jul 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719482; cv=none; b=X8mCDQokEpjUapY9IXlVefSGxqDRU74uCc8ZdHkb+qZJlTOoAtKstiFC9DTH4EnFIv82OjrwQyf0z0pINw95+mrZzdxWlSDr78gem4RTepG5AIw8wzQ+lWLuQBd3hKLQQJnzdoMnpdZaancbYRpwBRZkAu/hvFTG0TCfNsnU6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719482; c=relaxed/simple;
	bh=98RALP5EhtU61AnxH6j4PB0DOP0LTimcA5sGpGwg0mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZeRQLR01lC0RZmy9mausB+NGyg1vADsLdhArbg2iabUq2h5bpHCgoblJF6JKa2DuXhZEFPE3w8ImnCc/1yza1zqBmwFJa0fdAK315ZGINITXEWz201LcBWIjmV+xKZaZ5GE4XOVYAj6iuwiboIZjUQyXhUnMMp8rPWJhf3J4cfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg4WBAOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg4WBAOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F41F000E9;
	Wed, 22 Jul 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784719480;
	bh=98RALP5EhtU61AnxH6j4PB0DOP0LTimcA5sGpGwg0mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rg4WBAOvlVueN7T8T7WvapKvF7dm8vu2aCOt8s/Yu6FMgA9c6UQFw5NUhsCE+p25l
	 2jA2IdR359fs8xBxYre+2HDXLeDIFFsb0KYWqxDl9VENynr8kyZ9fnjzGQMNnNsqYz
	 1F+6QnQ7BuNz6LNcFpgobRMh5UHTI41B1xe5BfomXm6zxN/RODrDChrl8WOaDsM5+i
	 HF0XawHY7PhcxT910T0the3pPJXokdXuFyIyNwilB9pCemDRxgaS9cJtS4CXfSFSIO
	 suDcp35Brp8EQ1gV0bBtcAHNPcOmDVLCGQptt80H6eRsnllXyWhS81tm1dHAW5l/Du
	 ulWe4gmI3c6Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260722111640.1146212-2-devverma@amd.com>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:24:39 +0000
Message-Id: <20260722112439.A19F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Xilinx specific macros for MDB device can be reused for the
> Xilinx supported other similar IP such as CPM6.
> Renamed the Xilinx specific macros in a way that can be
> reused for Xilinx supported upcoming IP, CPM6.
> Naming is in accordance with the naming done for Synopsys macros.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722111640.1146=
212-1-devverma@amd.com?part=3D1

