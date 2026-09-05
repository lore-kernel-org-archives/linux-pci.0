Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAD371CE9;
	Sat,  5 Sep 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615804; cv=none; b=lXwPxd0bwLfuJvg+HsRa1LUsV84CWi4hJLjc6LsNB0J7i3x0KJ6pzOKqTCicQaMWb5auNBq3bfW6Aa2soZ6rC1b7pixXfWK7XfqcLErbIv648kQOwgo1moGYi3e6jsmBFwR+JHzUpOz0Q5MK5zP9i3cG4BI0wCL1opshY2RPMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615804; c=relaxed/simple;
	bh=nba+uMNhk83mXWH3I0apevvY16CcjejkZPNwPK1pO3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2p+vtRdwIl6yDBkQUVxJw+TAJMV1T+BUfSRqgUQS6Sr39uT5u6/kSsuY2cT73U8w2VpI4sqT22QFByvX+zyfo+xQ/T7DZPZlnSebTS/C+mLGZaQanP1MSunwcj9QSvIsLGzShA8HqC8dSHtqliJgTmLpntVIqPqBackmd7j8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OyomrHCy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OyomrHCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LC
	ZuJst7SDdVBXbEt3I76KSCd0qK5lhyGUPoCM24VrA=; b=OyomrHCy/4HI+9pu9Z
	ajBGyF35D00FvR9W7kGjHas++wineiX6IHwwPf+psObL6lAeYmvnr6UTjFMlwXLb
	hqt1L0VxquXR7FESOaLSTNQgfjFz6WmWA33LUjvvhu9Bw+oqSPqWvWMkZhJGbwGI
	wHMEE5rrP0GJUSgsoyD4NRBKs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnf71cHJxqOYRFQA--.53141S2;
	Sat, 05 Sep 2026 21:42:53 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yu Ning <ningyu@eswincomputing.com>,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Date: Sat,  5 Sep 2026 21:42:51 +0800
Message-ID: <20260905134251.67210-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:QCgvCgCnf71cHJxqOYRFQA--.53141S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUtFW8CF4UAF47Kr17Wrg_yoWDurcE9r
	1DuFsrArW8GFyFkFnYvws3ZF9rAa4xZr1DWa4SyF1YvFyIgr1UXF4DZrZ0va47CryrtF9r
	Jr9FvFWrCFy7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb89N3UUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxR3fqGqcHF08KQAA3N

The ESWIN PCIe host controller is a platform driver matched through=0D
eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not=0D
published for OF module autoloading.=0D
=0D
Publish this platform-device table. Do not change the RISC-V host=0D
initialization sequence or PCI device matching.=0D
=0D
Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/pci/controller/dwc/pcie-eswin.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controll=
er/dwc/pcie-eswin.c=0D
index ce8d64f..1bb4469 100644=0D
--- a/drivers/pci/controller/dwc/pcie-eswin.c=0D
+++ b/drivers/pci/controller/dwc/pcie-eswin.c=0D
@@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[] =
=3D {=0D
 	{ .compatible =3D "eswin,eic7700-pcie", .data =3D &eswin_eic7700_data },=
=0D
 	{}=0D
 };=0D
+MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);=0D
 =0D
 static struct platform_driver eswin_pcie_driver =3D {=0D
 	.probe =3D eswin_pcie_probe,=0D

