Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25141380FD4;
	Mon, 27 Jul 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176417; cv=none; b=Jj+VdovIgMtBsw8M5HC3OAP/CtYUdQFejDu4ZazS/ZBLSoqxmBthAvQ43HljnUPkAcjOK3JQ3/JpVzRZyG5NQjduw6pgqpc8/lohdwKIEevdXKR/DPXA6O9lQ6wIr+DUTq/ksgUAyHYFv2MTlKeXXoOj0huERtnZplo2zuJcL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176417; c=relaxed/simple;
	bh=csV9WpuWhlZBA3LAXCPgVvOpoHxeMaePZ0KBEePW4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2uwCwKdn8udrQzkMRzyXZ7/UO9OoFXg1Phg3Ev27QrztqQmSH57rMoMKVCRlOcMjGPFTumGAX7j956kcRkLPy/U1G1vnkyMPg5YTwFxkmxcUh8AGA/t/Z5vFJRbszC6r3Nbx/IhQQCklYyoFtxT8wI4t4NKTCCaBbrb6ko5vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=lb62DGh/; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="lb62DGh/"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 9ea33213-41be-4055-86e9-c6a3933aeaa7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1785176405;
	bh=csV9WpuWhlZBA3LAXCPgVvOpoHxeMaePZ0KBEePW4L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb62DGh/a9EgD2O9XJJZx69PSCCUQfj5+anz8TdlOD6y4d6Xzfh6umvWUMALWoz1W
	 N8vAfNL5axaBNQFlw5GTj9y/E0/2zpXD9R7Bz4GLdiQGroYIOHAOGCMWQAFdydtHdN
	 5ftdVSGuOm0zmUa2Yzkz7HJzbegDZFE6Idy1yZbnx/DRZyyBhhWRFeuvtdDiMEzYN4
	 xgusknlPyTEWdZbId+yZdFLznlBDaDA0+bYeec5Kvc9CvoEcNVYA3rKIaUOva+oaXT
	 /2r9iOWN8OI1Jxfhu6ASZsr3vmNls1W3Luy3M62/XUtasb11YrmwKtfj6+k7hmNU6O
	 2DeoTWcnyy0lw==
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Mon, 27 Jul 2026 20:20:01 +0200
Message-ID: <20260727182001.29728-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727112406.GI2365036@black.igk.intel.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com> <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com> <20260727112406.GI2365036@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mika,

the Titan Ridge and Ice Lake changes address the same missing PM
dependency on T2 Macs, despite the different PCIe topologies. We would
therefore prefer to keep them in one patch unless there is a technical
reason to split them.

Using the known Ice Lake Thunderbolt root-port IDs instead of the ACPI
TRP names makes sense. We will replace the ACPI-based discovery in the
next revision.

Thanks,
Andre
