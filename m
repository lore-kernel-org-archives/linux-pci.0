Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521291;
	b=r7CvyG2LdyDEcgXvQXUfE7OebdoV41T9UCnGm+J+RI86Kf4sC1qZi+BgWG/4jwkaMgYX
	 15uW8UhjDIBWpfPR3vmGXOSMe4RWJlcB2cP9trSNYkFQLubkvQj2mhFoj2wJEhhRQoP9M
	 +/ZErw1VwWDgnOlD6iFHrz2k+l9A4U0jaVZExYq51UKObbIX7GECvhPUp7nLazp8f98a2
	 FutoBdG554ilytABI4dta5pmsHW6vM0zypth5dfFR/2dFtIWRYO9iy6iGCP+g/wEK4Ioy
	 3pvh5+9kuL001J+78p4xIqCSFq9UB+atXvURBFLCoSJaDaHbQODsSB2uMKY1eVzes2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521291;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=T/XCcMtIyJeMT+WrNl0yaReR86Ki6Ko/g4qKifWyi1c=;
	b=EUadAIw955Un4i3BV6gCBjroH4Vd58qfJVp2GZd76RcbkMUSlcVg3Eyylzlmoo4U18N4
	 H2nPg8+dTO9jxdjAzcW7lHAQtkDFCZssZp7cSpDux3IGJiBRHe5M/vhcrVk1bnh6cy/wJ
	 ZY/X/V9JzgsjtP5PJBFGJiUF5rJW0FmqskV09HkiigP39ZnyOnC+Ew49A0SpeRK0sN0RW
	 6cqY+4pKwP3SzsAHeQTsJvFFymAbxWazL+gYJEQEhm51dpKIpCu7cxUhHf3M6Wehof+gd
	 YAKeGRypK/rCY49BRKoam7rzrnA6wtnvyuAM5++BP4nwNbOw3vnLwoF5qlMScxhy+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDK8jq1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853C606A31E;
	Tue, 24 Nov 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDK8jq1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B241F000D1;
	Tue, 24 Nov 2026 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521291;
	bh=T/XCcMtIyJeMT+WrNl0yaReR86Ki6Ko/g4qKifWyi1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EDK8jq1IlezR+p9Hys3x21wl3ktFNMJd4MCKf0moKM3UwTfF1XVd/MzXWZFF6aPl0
	 dj1lSLbeyONjlLHnQjFOu8lJeajJudx0RO/vei2Pu5+bHB/BY/VHhG54SZgDieLJpO
	 0nZMiQ/dFG4hTo9djikRJWSqXGRZQ2p7cjj/eOlZ8jlWUtxdbAyS0XT7MCmCzEydO1
	 ZXbuYDLPY6T+XuneffMBQoYdnzrrgWGgvcrqZEi02SVZTM182miKV4SSfvmvVvi4pM
	 Z/kp17rI5G3ZXOTeNqegz+5smE86JGqJsG8JNBRKpt2iTIjw5z4wOyXcRyjDNgPAUE
	 wM+y07QAbXsqg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261107-configfs-const-pci-v1-1-8545f5886a01@weissschuh.net>
References: <20261107-configfs-const-pci-v1-1-8545f5886a01@weissschuh.net>
Subject: Re: [PATCH] PCI: Constify struct configfs_attribute pointers
Message-Id: <179552128882.34473.16493029120563185271.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:54:48 +0100
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


On Sat, 07 Nov 2026 04:35:29 +0000, Thomas Weißschuh wrote:
> In preparation for the constification of configfs attributes, make the
> pointers to struct configfs_attribute in drivers/pci/ const
> and use the new ct_attrs_const field of struct config_item_type.

Applied, thanks!

[1/1] PCI: Constify struct configfs_attribute pointers
      commit: 2c9ea76b74935491078e5795e04ba3358e3d7a19

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


