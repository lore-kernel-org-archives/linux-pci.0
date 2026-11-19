Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085582;
	b=mgroH0ao4uYurCetgfyEchyW8fUr+2XnowsBleF5F+UgrHt2H1pXRF5lphylsqFAsVIm
	 jLE3ZupbUhA93Ln96j0aHnJSQVwgR9vSJBbWia6uaCkK9LCbEcxOxWmx85X3Pvz8lYM2d
	 UG/QUFiPVWZ7J/Ffzoan8tPRurUOgkVqtUc4QHrRkJi4gEcrxo9t4eStDskcx8GhuX8/g
	 h/XcPmj03VN5xeTL7W7ya6EPk7hOD5/4hpNetrKdnXtLas/bcf5nbtxHM2NlVdK1w9zfu
	 EO+DBWic3kmIkxA+6qaiUECONgOUYpSkhL8elWDQ/SWAmdlk2cNEUMekBoI7fmSF+Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085582;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=p4ujRYqqmDAxwCH1lLG5Y1TyM4iee8k+HiSVgBJl0UA=;
	b=W8CGcw7Mqhzi4retP7YmvaJUXQcVZ/We9MjmKdPLzQ6fqrCZsJcQvdbjOX0A1K4vfMEl
	 km52WW4aYc4sdouLnHJmNj3ClsNi8WvZpRPmHPuLOQyosTcAb+3DP9Os5FHdLghxfb4iz
	 F6ZAdQDtWv0RYYeD4Mo8FjUUWrC4NeiKWJFUJlk23xx180ggZ61OWtvbXODHmEUHu74hJ
	 9CHLFrESjycbl3KFehdU6msxpG0PtmIjttUWiguCVO7pqbmQXvgDQggF0/VA8d2eOWNn9
	 N0I16bg8u2qglIyBqpNDCDU6Xq+HW2yhatlRX8zEBqy7cTGCTNR4GiPjXy8LEv5r5ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E48606A325;
	Thu, 19 Nov 2026 10:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B931F000C5;
	Thu, 19 Nov 2026 10:52:59 +0000 (UTC)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9] PCI: exynos: Handle PCIe PHY initialization errors
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: alim.akhtar@samsung.com, bhelgaas@google.com, jingoohan1@gmail.com, 
 krzk@kernel.org, kwilczynski@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 lpieralisi@kernel.org, mani@kernel.org, peter.griffin@linaro.org, 
 robh@kernel.org
In-Reply-To: <20261031094911.3304-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261031094911.3304-1-sreekuttan2156239@gmail.com>
Date: Thu, 19 Nov 2026 11:52:53 +0100
Message-Id: <179508557305.20612.514486261245057380.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=bo2o/m3xmhc0NHfbRYvN0+MKz7iNbWMaHqO6Ffi134E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq/tUGDxYT92TkFJ8h+M/UgumGXqTFY41DMP4c4
 oCoGLS+Zn6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCav7VBgAKCRBVnxHm/pHO
 9UdgCACNwn/rHgmgZW7N9z5xuwd/BcFD92q0D71p6SkcsMguN72bKKI/g1+xXy8+XjH2TxLb9Bi
 ChgsRrTsCyn8Tb/vGIA1RT11JBgv3RMu6NpHhY3zVJq1AyVRiDL7uf6iaoRGQi1MDGhRd000zoz
 IWEEsRJxJZZhAs+rynGJJDC73KcNNMpk+0qYyM/U08dzb1jo3qRrIrBBzzDItyaEBPT3Q6T5QKC
 5/iFYvJ93HsBoL5um8rAzVch8/rEuOhx4kK8xEpFHuzDyTW6HizxmCR6V79Cd14oZXKZ7RThWGZ
 pU2j9fj2dcAukWuv7QeD2tYeqLf9g5L/9SUoYg2W7dhJij+0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-31 09:49 +0000, Sreeraj S Kurup wrote:
> Check the return values of phy_init() and phy_power_on() to avoid
> continuing PCIe host initialization when PHY setup fails.
> 
> Track PHY initialization, PHY power, and regulator enable state
> across probe, remove, suspend, and resume to ensure cleanup is
> performed only when appropriate and to prevent unbalanced
> reference counts.
> 
> Assert core reset on probe failure after PHY initialization has
> been reached, and handle cleanup errors during teardown and
> suspend.
> 
> Also check the return value of exynos_pcie_host_init() during
> resume and abort the resume sequence if PHY initialization fails.
> 
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

NACK.

First of all, you are sending each version as a reply to the previous one, which
is not recommended.

Second, you just ended up fixing all Sashiko reported issues without cross
checking whether they are really valid or not and the patch just became noise
now. For instance, this phy_init() can never fail on the only platform supported
by this driver and there is no PHY power_on() callback (idk why phy_power_on()
exists in the first place). So all the error handling you added for these APIs
are dead code.

So please, do not blindly fix all the issues reported by Sashiko. Do your own
homework!

- Mani

