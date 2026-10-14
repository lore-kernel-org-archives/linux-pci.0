Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405A47A88E;
	Wed, 14 Oct 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975646; cv=none; b=mliw6Za3oQCVXb4OS8O0VQDXwc5fR7/yXEB2NVBZAUDtGRxpaFtBHB/2qzQPJtnWxO4xsIh+bPVE7z0zooo4uSi/MPzBYLtdrAjfRrvJFUrWDSdGH+oWyaYF7peuMp9zz+yS//bJwXbPO1Is/uaVoDcuU8Lp9GEqmHAD/jI0kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975646; c=relaxed/simple;
	bh=m2zGuI1114KB7j2Md4jUhmFglPbeNlyzqJzKL4P086U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V1szGe/qcQr1kSTjBojJb1vb0U+nmpDd2/MBvj+gtvdMkwv3jcgByhnCudVIzZlTHDyDiNiiDx4301soRjBP8BQ/W3d2L6rGERJFmZcshz7KZPD3aqCymrx5WsUWStogwufM1jeu0oIN1Oz5FjK5vLeLSK05g6nyNv8dLMDoRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC31F000FF;
	Wed, 14 Oct 2026 11:00:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] PCI: Expose
 devm_pci_alloc_host_bridge_release()
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Semih Baskan <strst.gs@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>, 
 Rani Hod <rani.hod@gmail.com>, bcm-kernel-feedback-list@broadcom.com, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20261013220421.1588051-2-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
 <20261013220421.1588051-2-bhelgaas@google.com>
Date: Wed, 14 Oct 2026 16:30:35 +0530
Message-Id: <179197563532.38040.2990484499406539707.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=639;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=m2zGuI1114KB7j2Md4jUhmFglPbeNlyzqJzKL4P086U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz2DWgeXL37dRXhlsw+cju33dbarzvO4skPBCf
 XNu9gd5OPaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas9g1gAKCRBVnxHm/pHO
 9ST7B/95w7G/Q0Ayf+Fn8WxvcIro1W8eLT4TqGaJ5xN5vjz72qAs+mDUnuUlLWWaQwx4O/IyI32
 0tlfRfuxr2yU+qb7SLiNPskgPQsocJ90VBkCsBG6VXbTy8XR6JXE9BGqJVghyN9BdlxTjWP9LXY
 kp2Z6cx+UsoJ0xmNyt0fjFmwcey8jCZbmqTg+AP9ffMKUppB35fHfFiPvS/RyGC+h5fsf1LuYDH
 yK21Ulp7ZnybzG1lRqgTRiH87OYwPAgrJVu+ujPNROPZ1TdkhvM49r+kkZcLsgFtnYQ3JLJMA59
 QIFFwRJHGlemAsi1fGGHVeBF32u1954SZ11WsUnk0kCjae2U
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-13 17:04 -0500, Bjorn Helgaas wrote:
> devm_pci_alloc_host_bridge() allocates a struct pci_host_bridge and also
> parses device tree resources and claims them.  There are drivers, e.g.,
> pcie-iproc-bcma.c, that need to allocate a pci_host_bridge but do not need
> device tree resources.
> 
> Expose devm_pci_alloc_host_bridge_release() so they can avoid the device
> tree parts by calling pci_alloc_host_bridge() directly and adding the devm
> release function manually.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

