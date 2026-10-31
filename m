Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431719;
	b=EWdMkeGP/v9uWVVmvpjMVmbtotAeeEsEsFUG12HfokH32+E2HCwgN/MnTs8zNRFse7Xm
	 QrwAgCIXCqJX4I2EoXpPZ22KGvinAsp3+s86//GFkJpMwrvCBxv0YB7PP/GwWjb0A1wQf
	 +WC9kKOf3GKMUV3hIB7zzzQMfGwNd4fYyyArNeO2B4lVpdmg4KPURJnE6UUHSQnUSBsNa
	 ECu95hhlASSljVsoU/KO0B3yXCeA5Fy3E3L3VRjhBlswv1Y96wgeE2eJ5ZgGIKDgCqfPk
	 gdHUHfiu9h6Ncwlckrbh62VzUgDB9anZnYxBUOfMUMrBRVbkXdbsaiLK2qkF98hE/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431719;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kaQKtpGNCV3VICS3ZoD8AqFxMAdg5Nt2CMBhCVVlohE=;
	b=L8ZtlnCncE2oG+/kWU5va7hywHGvhV1jtBihacy3mVBK0u9w3MXwmcOAefS+9XWHAm1V
	 s89i1MEr7XAcDI9Sp7/i+/TUIeJYe710RC47Ri9Ms35JimEapFegYb+hgnDLFJE9UAlkW
	 GpGoqcm7/eVMa3LkeiGwFn+QG3z4DbS0kLnwKkoBKxItUhri4S03ULmsS7MaU+fltbvD4
	 CW7P22NtHhAikIcTqLc8PiqVJl6xKGTqzm/lNW8NVo6y0UQTYltPQ34SYa2ONZ1/ouStM
	 lpcSj1c3kLMZHUCT5Dll/FMlZHgGw+dNOCGsrJdq7VgamzPUEZrVxa4OgQnb3u9/thw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofhfZw26;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B21606A31C;
	Sat, 31 Oct 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofhfZw26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A399D1F000C1;
	Sat, 31 Oct 2026 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793431719;
	bh=kaQKtpGNCV3VICS3ZoD8AqFxMAdg5Nt2CMBhCVVlohE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ofhfZw2663YnNtfsO7hGUQOAyvuyLUOnsqzxsSJ3EvypbjndpAWYxSqDc0N89ipl3
	 n8K03ndZB/Buk3NgtXpyEt1uJ5XrGw/fiZbYidsX8gTZcQLOKW88cKrtK845KxvaHS
	 0OjO4gU9PYnwFtKQBki4g3Jl+EakLu/m+/qeL/TBt7npm7KAud/FX2ZRz8OhxUjcij
	 n2ADhzXythhkHw0dUTlMB4qmQntbf1mcs477Hf4zwoxEAFp6VRcdZ4FQAu0Nc/+Hdc
	 r9+UF5o2IGTxXDgIVK46ED2x8T0uyKLAc2BzN1FMswNdl5Y3W+P26m/qSid1ycrcUd
	 eOOvNmkIHP6wA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Semih Baskan <strst.gs@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, bcm-kernel-feedback-list@broadcom.com, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20261019065249.552-1-strst.gs@gmail.com>
References: <20261019065249.552-1-strst.gs@gmail.com>
Subject: Re: [PATCH] PCI: iproc: Skip BCMA-attached controllers in the
 platform bus driver
Message-Id: <179343169507.4244.184173926392440151.b4-ty@b4>
Date: Sat, 31 Oct 2026 12:58:15 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=361;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=r8M8RLNtFCfKfZyDz6n5ADB1vpME3zRi4JkGfSuPlEY=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGrlmJ6gHmvVVgi3wmfeP477tjOsNZDRxs7Xt+jN6SO6NTxIi
 IkBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJq5ZieAAoJEFWfEeb+kc71DZUH/j0o
 7LKG2vQQSrf/oLw9G0b1Qyks03kQeytg+Cjj5a4mOhpxsRkUsZGx4s5I1SfndfvKPRIxyqpOs0F
 uHPK/6vKGPXdk3Srixnd9m7aHPmPW2TvmVDkTc4zdf2O9Wu+xtv+x3sn5knRc96ct3i7xcMCth2
 hJ6V2qHvt8UfncrLSjmrhrkHhyoBmY1apesbV4NaTb+Xvw4cTImBZOFa7Mv3WRhO1ib21IafilN
 Kh02UQcSYU7m5FVYhWFF/K+s8UZTrD/7dcB/sbRmTB089wVeW37NIVhjWr4XV7neZLfaQUQ9/DD
 v6F7mvuyErISEnMT9tigcVXzr+asGa5J1A8aZ4w=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 19 Oct 2026 06:52:49 +0000, Semih Baskan wrote:
> PCI: iproc: Skip BCMA-attached controllers in the platform bus driver

Applied, thanks!

[1/1] PCI: iproc: Skip BCMA-attached controllers in the platform bus driver
      commit: 4d3e0b32afedfcbed5f1e38ddec035af545e64ef

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


