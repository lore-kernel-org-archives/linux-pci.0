Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625821;
	b=ZMheGsW3aOLgpLft2kUx0w+b/ijKcfGWNzQNV5Yfam7AdiKYsQC2qu/IJTNyTqAMDkW4
	 cV/YJMnJKH8dei7XBDAo22lI/wRxnst7dCJT6fIhK5sC70ussHGFtC1G0iLcVgIwn4TFZ
	 D5UaqksRrarM8FYlCcWTXukfWdC1S3XLPTY8vyc0E1UDSe4cZmKl/H+w74JcWC+K+4+d+
	 OFtXcLZx9U5CyQ3e+j+XOOcva+DpCsFHcElggJLtbmJbbOlHSnzqsF9MMFLA/u7yn3gfw
	 9c4SqIdFmwL7cRJjXlzyNmhhGlSADbH4dIMuqYX34bSDyeWSsvlbyJBpaRyzglhvsiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625821;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7ayXOfVT38fNNXhVQZJD7BxMf+msWkjBpfCELCX48Lw=;
	b=cG5NoiGaM0ZbmqH6XC0hFmr5hM0mIA00oYzxQYPuGUEDU8b5gSb7c48nTseCLQdvNc3B
	 CLuabm8rm5qmsA3VN0TX3yAqETBQOtqUUNZqqJja1Cb1R66kb320GCyVVvMvjkZriBDuW
	 jOJoDKViQuJdyJzC6FT242hcAru5duVhBm2V8s5i4IL0r1vZBAmwAZfdVdzitz8dMO+lT
	 3jRkQm2XoI3hRUwrbA4f8S5DoGWUjxV+ZxXaLyXdz6sMJPcxsTxAxRfdyqkgi4liSSdqK
	 aaIPem/Z/EWAUlA2juiCIWLpd4bCelRpcwLeBnPUqJu+b4KTqnWwMGeFawIWWUVMdKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0D606A326;
	Wed, 25 Nov 2026 16:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A331F000EB;
	Wed, 25 Nov 2026 16:56:55 +0000 (UTC)
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
Subject: Re: [PATCH v7 11/14] PCI: rzg3s-host: Move IRQ domain setup code
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-12-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-12-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:26:51 +0530
Message-Id: <179562581171.5580.11485969247008114241.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=211;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=SDjk0CqIeSZspvTcR/jFZd/9D08fYAjch2jyNFdx0ao=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxNXLWcZagBr7cmA8GlLA8I2lpG/bFVbCYDIm
 23263mFthKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcTVwAKCRBVnxHm/pHO
 9f5PCACEsd7zftNT+C0HcTbtaSGupKAuI4VTUJschIb2xpyv24j6hC+rQy7btfUXNapgAjMTwUN
 zuKDRDXwh1qk7gebD5dsHeEL1iCk/1Xbxu5t6p4CO8buc8VMTxeQnFcgt3LC31yUXX6489JU1kM
 4AJfdxXfXfQoogmqeVvfQGmDDa7YotJe7FWn0kDw7t1SY0bstZYO4x/ip105zhLF6Y7i0lslhWf
 UiVuStd8g/Y3tJZaLEaALYzXqUylgMIR9SoCG6o30lcBtpIT1slmGgql+itVMrajArebUXb5zvw
 FALpbuVg06xiA/Q6U2VGWzRDpYmHB9Ea+JIUmkQbcQ7T0E9L
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Subsequent patches add support for the event IRQ to handle link

s/patches/commits

- Mani


