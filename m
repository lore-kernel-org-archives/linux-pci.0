Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625767;
	b=dvOqG2mHEUEzZfU7wrL7nvUT/xBwxCdwIBZkqzeFhgGZAK4ys7881wYuQRZKvLKPodVQ
	 sbz4deivYG006GuWl4ZKddL3ox082wbgtF4dWeLo/75YJ651AhcqBklxavphi7+Tw4gEO
	 XHDN/5NcrZ7p56lMo5za/yrnGBZORnSUuayPo5lcbedLzSLUVUwbCRLB+pz2X3d8hK4h8
	 gRBc83HiS3ellNT1Ll3Lv+a9o+H5FwLyiRcOYdpfht50r7SrROGUeK63haUnzacLkGlyt
	 k5EksaQpWc5IPSB6/7aQ9fCPKzNT2+NJHDxJKhuUoMGGBRSCveQ1MBG5Wt/qXHVEF8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625767;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=sl3XjpqHUySaLcpibfs5vOgS/etUvzwR6CVqZL0TdnU=;
	b=ev2D+yUcFVqCr2SMrkR+qD7WOra5m49Mqa6gWqQFMy8tRmtbGx+/gJJYcHon+r5096oG
	 U9zB+4t43JX9H3/dTUlClA3ZdAE7uHdTSpOQD0C+Jq3MUZBKKaAGBr6sE0t7hx8SWZOqn
	 +JstghLyr8j79N4nOwcwSKHk+MjKA52H8VkG6WMiD7/IRQs9kj6DsyS8YzKkiKXoiE/nx
	 /ijxwwYBov1wn1tM5c68htZHRZKjRhczUsci1LmwhYJcCNNNXxLdcWhY0Hwq4Ga9YlyAw
	 AcLWj0gQhWIEG64w8KGHGzeHVrJRoMb3Ng3bZ+yEl7x7mvlgibflI5E8m/22FF2wYOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51D606A31E;
	Wed, 25 Nov 2026 16:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A851F000CA;
	Wed, 25 Nov 2026 16:56:02 +0000 (UTC)
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
Subject: Re: [PATCH v7 10/14] PCI: rzg3s-host: Move suspend/resume code
 into dedicated functions
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-11-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-11-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:25:57 +0530
Message-Id: <179562575756.5580.12529619216547597559.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=548;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=es3u4qpah4vSw4YCTCzXw+x/GiNpguUc5Pu9KO0CPn8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxMh+zlqiVvwdP/ISe+y9XKHO+K73XKYEomRT
 GPqtfpsoOCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcTIQAKCRBVnxHm/pHO
 9VDJB/0SI9kgEO4M+jsvdpKURd2kKWjZIYZYeu47Jh3p0Y9ADWPthdcZxG43yddlgt9AvlcifhJ
 L14QI85oHA8YNogacxdaw6G8xmqu9copstfbdTz4w4pdOcFH3qjOZ72K9d3Wb/gHABBI29SkEi7
 9yGSE1WMTFgl4VJjPu6kwFmcYdSmI35L5xdrqZaD9H4CLc8ZZtZyUx7gi8jWGqkb/yXzu5R81wG
 HSlE2hRf3a7pGicJps29QXZA+WgRcX+oKU4O1/gVTp8sS2nDfUvP6fbpMk4VDuxxHPy/zCgZxIM
 i6VokWoFQrTIAbOfdnOXL+OdwE811kA868psf4xufBidXb9P
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> In preparation for implementing hotplug using
> pci_host_bridge::reset_root_port(), move the suspend/resume code into
> rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
> will later be reused by the hotplug implementation through
> pci_host_bridge::reset_root_port().
> 

Bjorn dislikes :: notation and would want me to change it in commit message. So
please do me a favor by switching to '->'.

- Mani


