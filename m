Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285303;
	b=0URb00JJEzKQc2zdDBo53H1igdre2Gb/GcSf5CX6PIthr5aTWGCx+1MLOOwpMzT1+j8n
	 ztEuwCUTnX/5KVNMwD2LoLvsd5qzYiHo1VjmpSOdXOKiX3wuPjr3F/VM8nTg7FTJGw4yR
	 6IF40HZ1CKxkOo0GSAN9VLN/Tg8Tv9IH3XdJQdWcWg23hMIgqUueyQ7JWoI7Lk7C3Sxhw
	 Jpx8t4Qh1OKTfPXv5PAUB6qHFTsfRc8IQJQ5Zi4aFeb2gLS5XcbJ/9VfuqVBDcUXWzddD
	 y3bX9Q8M879lPjElrhq1mvOsKhaE/rDpV44F3xVn504SC6YNkIWIz9p4bwy/w+6bNqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fttV6xK/wiAMrm+IgHFd4MzCw0BG6Ef7ml6FkhjfXNg=;
	b=3JqQkTzY1b1UuxsFTmyUW8/jDnvsYYJ4Va8eg+y0mPBmPHpkMQhTFHiatJFp7Z2scN0f
	 GhEpkCdWnLWs/raIkr05PHvVKl8ulmgyJC0wQog+Gq9qA3n+brXhFAokgdFGoJThwJxUp
	 RFdVlUuMUGlGsIuVPm1e8unleE8KqqguRwAxWvvwbYhEAu3Px78QqcxR15LxUr4NOzwtU
	 rfaCFM0f55QAW3cFtaGEWAeUFueLCVH9QpBZEvnc1ymGP9U9ezLZjMczQX2p6WLUA3Hda
	 EKBIIcS3uW+e2DU7PtyDmC40wxODsnL4aOyn4loOrbeiPmH7p39HMJcuRZ6Z+NuyOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVq0ZTZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1B606A31C;
	Tue, 10 Nov 2026 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVq0ZTZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8911F0089F;
	Tue, 10 Nov 2026 04:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285303;
	bh=fttV6xK/wiAMrm+IgHFd4MzCw0BG6Ef7ml6FkhjfXNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVq0ZTZvislLeFDGGUtKnXwKfskL2EhQkqJJ7QnSM5ftMautN71Ky9lxu4eGlPCCv
	 vmEWGrEK2ATJ6OBhUSDKcPqKKc5ra7c/nEWOT461x6cMs70BGN1WfZDq2Q4xENtCfy
	 wxn8Q/q5FfjomF9dVOXe7pKUNR44WBn6SaJDrKoNC6Xw758V5UwPEU79y8Afh5J/3x
	 5p14+fUeB0GYVQbeqXO3Qw2A3nSEaJtk65XwfbEzRigQv7yMJmmUG/VASah/ZqixJ7
	 6Ys3CYXXe+DsZDOjOQBv0rnOolQpcDumFK4GY46NSkCdfDMfJJOcj52TzteHE9tc5o
	 PNwDJWzGslpSg==
From: Bjorn Andersson <andersson@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	Alex Elder <elder@riscstar.com>
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/3] PCI: introduce TC9564 misc driver
Date: Mon,  9 Nov 2026 22:34:44 -0600
Message-ID: <179428529354.1061455.14011360627239052056.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918152659.413268-1-elder@riscstar.com>
References: <20260918152659.413268-1-elder@riscstar.com>
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


On Fri, 18 Sep 2026 10:26:55 -0500, Alex Elder wrote:
> The Toshiba TC9564 is specialized SoC that implements a PCIe switch as
> well as an Ethernet AVB/TSN bridge.  It also implements other functions,
> including a reset and clock controller, an address translation unit, and
> a few other devices.  PCIe BARs provide access to registers that manage
> these IP blocks, and the SoC is modeled using a PCI endpoint bus in
> devicetree.  This allows the IP blocks to be bound to platform drivers
> using MMIO through the PCI BARs.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses
      commit: 12f074acca972ca6b3a2317c2349ed93446e01e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
