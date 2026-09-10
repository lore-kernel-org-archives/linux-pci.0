Received: from send175.i.mail.ru (send175.i.mail.ru [95.163.59.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA6496D33;
	Thu, 10 Sep 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070922; cv=none; b=rfs3JOeS2HVquSpDCUTx1t5gNkNGAo+vR5NzIc+HAJM8qr9AWGU8YQlhmGHdKEQ52QIra8tvdxmZRwddukjKYxyJjgyhjOdY4iZCjCTXUrZeEVxSv69FKiso+ojLASd1zivd0MR24gbyBxEU40KlvlrQ1YxPNdrcw5oYaWJdTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070922; c=relaxed/simple;
	bh=/NhhxOeq1zCWY0FUiMzO0XSk9EkaMFFKtzktKapyEUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPnzfvFs6enmathaUYTYuSZo0jtlHfWulNfitUsxeF9vIkeUkNNhlY7S5owM8g50dKl4btyAuw8sN1FnTRFCdRkPhQebAyYZDlI6/u5v7BJPedwlrkNZxOCTGJGU7xYsUsZ+hkfmXVlpZ9V3asThCHZMOOgy/AyNqgk8L1WZ0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ojHzWf+m; arc=none smtp.client-ip=95.163.59.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ojHzWf+m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=2ruLkup9mQFIbZ6ab2AlWfZ30RzMoR+bgXXMiL89Em8=; t=1789070908; x=1789160908; 
	b=ojHzWf+mZMaos/uJ8AFWtCVHRvVQcDYQSuJYdCoUvGNxQtQXWIjp4disfJ3oBFGtHWPhS6eAXZj
	43XCwxTPJVychJU2Xy3WowecQEmLUMYF+FI05QKY4M2j3FJrzS3TQWUj51mtTCu033Nfbr8hn//k7
	apPHtBdrlUAnPGKmfN1sTlKkMYIfm1LIu/u/NOry7MEV6W/sqvpwkB/hxwQ1Rv8TTqU4X/AXQiGcf
	2SYekUMGUFoUp4F9Vovd8wxVBNgmC1m2HVYDBqhlWWEtJd639KG/KpmmbhZ3P/JwA48Pg2OIr1IoS
	nkim5sZRCw2YnNx3iYNd+xol6emKvbqJ0Dyg==;
Received: by exim-smtp-569b45c49c-g7cgv with esmtpa (envelope-from <gvozd188@mail.ru>)
	id 1x4l4C-000000008Aq-1T90; Thu, 10 Sep 2026 23:08:16 +0300
From: Vladimir Nedoshivin <gvozd188@mail.ru>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	linux-pci@vger.kernel.org
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rickey Bartlett <subtexel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Vladimir Nedoshivin <gvozd188@mail.ru>
Subject: [PATCH] PCI: vmd: Enable interrupt ordering quirk for Arrow Lake
Date: Fri, 11 Sep 2026 00:05:39 +0400
Message-ID: <20260910200539.10862-1-gvozd188@mail.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-569b45c49c-g7cgv; auth=pass smtp.auth=gvozd188@mail.ru smtp.mailfrom=gvozd188@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9344F665CF1C84C2981A1698E91343846B74679370425764E182A05F538085040A628F2C5F81950183DE06ABAFEAF67053353C5A7FB98630701EFB9880373D310ED52766DCE320BCF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CF4D16325FBE1EEDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D9647610B5273090A37AA41B17D77CC3796A8E455FABC8A9CE322FD8EEF46B7454FC60B9742502CCDD46D0DE753FA5741D1AD02F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249A0EE70D6C4970CA7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B3849D6E5CCBAFD76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B17258FB61AECAC27EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C363D77626233CE5AB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5ECCA2ACBC18B67B95002B1117B3ED696457D4716657C60AB4869453249F34FA4823CB91A9FED034534781492E4B8EEAD03B69CD69EED70A1C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6592C3FFCD7D807A2A36A431D01871D96D946BB3E717B2D6749798D93FA7C42AE413DD9A946F941C49EB8341EE9D5BE9A0AD4CE9DD282B2E38B60F3ABEEA71C45A0DAE832B83437631C52EE4E5D9E54FDA4A7285BF96B6084FCFBA54DA8216DA934F6C4A2408CBCF31D24A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw6dS7By1zzJxZN4zK4WMRzE=
X-Mailru-Sender: 159DE679A9C6F65768E931FEB494563F1FF8F0C8259580231F93A76BF6F7B0A6144E53F005E138FF5FD1F06B50AD27C8FF5C3F970EF126FCC77752E0C033A69E4EFDF867BBD1019A58DE3A010156C131B4A721A3011E896F
X-Mras: Ok

Intel Arrow Lake VMD device 0xad0b is affected by ARL004. The VMD may
signal an MSI before preceding posted writes from the child device have
reached memory, which can cause the demuxed handler to observe stale
completion data.

The existing VMD_FEAT_INTERRUPT_QUIRK implements Intel's documented
workaround by issuing a configuration-space read to the MSI initiator
before dispatching the interrupt.

Enable the existing quirk for 0xad0b as well as 0x7d0b and make the
comments describe both MTL016 and ARL004.

Tested on an MSI Vector 17 HX AI with Intel VMD 8086:ad0b and an NVMe
device behind VMD. With the quirk enabled, the NVMe completion stalls
observed without the workaround are no longer reproduced.

Link: https://bugs.launchpad.net/bugs/2166325
Signed-off-by: Vladimir Nedoshivin <gvozd188@mail.ru>
---
 drivers/pci/controller/vmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e45ef8cb16e..9d97a832785 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -94,7 +94,8 @@ enum vmd_features {
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
 
 	/*
-	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
+	 * Some Intel VMD devices are affected by interrupt ordering errata,
+	 * including MTL016 (0x7d0b) and ARL004 (0xad0b):
 	 * the VMD may signal its MSI before the posted writes that carry the
 	 * child device's DMA data have landed in memory.  The demuxed handler
 	 * then runs against a not-yet-coherent completion queue and misses the
@@ -131,7 +132,7 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
  * @flush_addr:	config space address of the initiating device, read before
- *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		demuxing to flush its posted writes; NULL if the
  *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
@@ -1300,7 +1301,7 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, 0x7d0b),
 		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb60b),

base-commit: 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54
-- 
2.53.0

