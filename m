Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA2202C48;
	Tue,  3 Feb 2026 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087179; cv=fail; b=RRm7zvlKe9sAnLZPd8Ny+sarsDNSPJNpuAD9AcD6eO+5ehqiHvLtiVCBKKwGNwOYVA1rb183KdQ4WTgrhywZz1MNeFKnMWyG27Oi4xhwo3ybE3q8Jzck8p7zfN1iy1L2wAi/EpWXqe6t7FFPEhvKAC3rWxSYL1L2+0UX4jTtAaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087179; c=relaxed/simple;
	bh=CNig+GGeyP8wDHF1ZdYlEzpunhv60ToJOoT8wjgdCIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FNu3VjC4yek+8FJjv1Kdzd8XY95g08PtSyFkev6sCjkKGHT7xO8XVRnbrGxahho7ev0yZV/D+eUn7SD2pbtYtwxZlqAhpnC3Rd229GFs1bC3vUxQs41y1/+ss0FMboVCes6gNsNi2FlPamH1sKtPzCt1v+EfsZ4vy7FLA8rNeXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VhutqCgn; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VhutqCgn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBYAiC3daEghBN+TjGm84zXFSk4wi4JeH1+9eiAAko/25HYE/iTDIEzq4XwwHLA/wv/hHMyjnmtc1mDRsK3o1P7cmO/Z3wwnMAN3x8fsoMazwi+gxP/x9WI4xszVTQa8CE/kwED+EKYVJqy0hmz8a0bFohpkp722LO+JP1t9IqPeE04acWFgABONuJZ56r69aQkRaoht9ED4S0Cdd7TOpGL51ql0IcXwj3YJJltiXcMGkFbk65+06fzYpXfgRcyy66Ask1SbH+b2HkgL+I48uyQT7alfwzlHUUlGKZkD+SzN+35PRTYgzrYraZivtiUc6R2vu6ahfe/u+0lJeM/G5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kW1AYXuoD4kGvLfrfeoFMDZRDRO+MkvKqRvejGg6Vo=;
 b=rMHxHX31a8uRdD9rSBZPscrdgMYwIO/e0W8MB8dPPrYWoqjGbwsyTO4nTRnLaCAix0Bth72p51Zy0AIXvrNtVopC+wArG4v/nbuNnvBUiGiuJJeqBwg+UKABVvg3UNZeCfe9VqqHxJ3fPPc8NZRafF4PqXjemxVDTglMcyiqsY2t6z5b1n/owB5RX5GrCdUFnzQuU9DgQWj+k6kUHWg9ZZsZaMG7zwXK8ApyxBURQSAw5jm9L4cXrEr7OkSUSiDR3EeUc8wNE6+MgUA9k4Gqbc8/nrL8duAWVAmImrerFaO5iGVO6YFPSvYCE7UocQttDBgflFzWbyX/I3XDjcBpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kW1AYXuoD4kGvLfrfeoFMDZRDRO+MkvKqRvejGg6Vo=;
 b=VhutqCgnZ4828iKxEu8T0jY7ETc02ssQLm2t4LLij0JaoXMxeolaT6ldjyl6gofGmG/BNIzfpplSX/a+6T9ok6X99FLRZDNF37cNzqgfevb3vk3i7JqoS7yyRfA2kb23nbmq8s8UrlNVLddN5rHYTEHcPdHgpNpVr63D+T/ws+Y=
Received: from MN2PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:160::34)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:52:51 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::81) by MN2PR13CA0021.outlook.office365.com
 (2603:10b6:208:160::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:52:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:52:49 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 0/9] Enable CXL PCIe Port Protocol Error handling and logging
Date: Mon, 2 Feb 2026 20:52:35 -0600
Message-ID: <20260203025244.3093805-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: e875beb6-f769-4fce-ca9b-08de62cf5208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7WPK9Z046RgsUURuEKQBlIvaNLtzreTKjM3p3hRMvPeQ5qpFIYRd4BbhV3u?=
 =?us-ascii?Q?Twqsw3d1bnwFAXnQQbebGH/xQwcxDnOEcu4amivxDNyepUNt3QxfpRbCAhfc?=
 =?us-ascii?Q?LqdwAKZpuuTNWGwF3ei2RXNf9Mtztiyv/iTsINlvYGx8ZV0+PXHG3K9rAEsw?=
 =?us-ascii?Q?ie3wCGpQ7/hacjeo0EqBkuxfEa6RmyLrB7W6eqk1mFuvpyCvcCC9TzjP65O8?=
 =?us-ascii?Q?UQFUUE9yd4qdTYOe92vaQZQFRxAtmcRPAx9xg5aPBT5KyYBou/AuQeT47tRq?=
 =?us-ascii?Q?8yhKPkXxsSDbnocU9fGc9aBNEpkfaWFDG2wyl4dnFCwWdtSAcitGDHTpixlx?=
 =?us-ascii?Q?ZFVU4af+QgkeN8hcsgTgbz4pUi1G9O5L7g8lO2FffLGhsA54cE75Fi2Ljc5b?=
 =?us-ascii?Q?xdag5TIc+LLl+k01H5eAjClc4P1Y26IvT7oTbp4sWkLQaGBcwLzsCnkl8Jym?=
 =?us-ascii?Q?tr3dE5sSs7OrNlajtctS30q5wdWLSHHi3pF7ZhzTRUX6EVQk2p+ANaMm2vph?=
 =?us-ascii?Q?xfc63Y9Ji/DbDvdPNDrLGGVNJtfjx7e1pFhGG3LcI5eQTy9tRCSjwIAdT4y8?=
 =?us-ascii?Q?/p4MX/beGZV4ifg+r8ETLj0rJfNtvxOxhlIXwVg/bZxeX/3zrMhXePlUpcaS?=
 =?us-ascii?Q?JoVrkHFqqegWK3j8yGmp4aMbgFg93KnjKW+qF2sw/JsVVbKOPH4m93YvhW+p?=
 =?us-ascii?Q?n5LZAI+XNGcLj5wn68QZ3W31yT1ybEEE4Fj4XcnEeB9P4VQN8T74bZQTjCJh?=
 =?us-ascii?Q?RNXH7Z53M4CFnAvmOH14USpKzQicHr8PSgh4iGX3fGvSvjfnD6o/qZpqDCV+?=
 =?us-ascii?Q?d9QjNQHZcFmNorWIThq+isDGNb3uk1HnWdC8j8PV1iUBKhY3OwmXYfZV0LHC?=
 =?us-ascii?Q?//Beir5J33TG38THChF451IaYleaOa5vEuKQ4v8WSuOyB9bZ2IfgPIXGYTI3?=
 =?us-ascii?Q?ewKUknY5bzsmJnU7dABXYbiHl6nYf6NbfkxKfdlWQsUDMPY1ruWAR9D2g31z?=
 =?us-ascii?Q?UScJ4MpJN7foH+UEwU0DfTCyJFKe42qNINERsjf38WK5JT6VSoGbVgBk32RA?=
 =?us-ascii?Q?31sm0ax+So/0x15K2gRh/vopffl3anfM91zuRKK84cqr8OtaZmZ2OH+LK/f5?=
 =?us-ascii?Q?TotTn/ZIMAmIDK5taB0zR0GY460VIgMEIfcWnoUmUIcdcxBoczLgncIoRg+Z?=
 =?us-ascii?Q?vrTc0kVMpKdEyoxI55K8OvMizE3X4aBjwGugemasOgZobpt8sXoqHcL4jm1x?=
 =?us-ascii?Q?wQazdD3X8bqOXaUPFw1ZDPmVu16wpPRTBgJF0YPlwm3cn1m0dCfbq66BiDXD?=
 =?us-ascii?Q?Zi40K+x6+xrZ1KrIK1nw7kt9Y6ZY/AfQdxwAy4OREobWxsbu82vcPdxECrHR?=
 =?us-ascii?Q?WTvjATEJwTsNZRJPmH2QGr50m/V0STmMrfzf6DBaQmu2X9FDXhaYmvfvyiea?=
 =?us-ascii?Q?0ssiz9mSQ69DTitPXP80zCUwZIx3/gVHZsE0y/LTPyBM0kWD+7mJg7V2O2F7?=
 =?us-ascii?Q?2vJNOIMRnqKodWsYIqJMfZf6+8vKZ5t8ups+wxtNyvobXm62BxKhDvFlG2Wo?=
 =?us-ascii?Q?ZyOCrXplnJhD3piToeunvKlJEiCK4MIx2etVslSqw8jOn0/pxZ9cjZSDFVhR?=
 =?us-ascii?Q?mPK+tbMTxOK6WuR5GBzqAgDobPLg3RwEdKxXRfhW5LaHCElQKhoI61WlGh6Q?=
 =?us-ascii?Q?3ZLT3hnkaWJy8YXEdviEzBd5LNc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ui3ob8TCABIF9BJNZKLpOyXLmi7D+fvhLejGpCeGeZVJ06E6TM0xsooq/Y1UcTF/yzx8tzLL3wZjucVaY1YFmp0TvS/J+PQk10aFei6bTofNSWwPk2YH3o0ITSEB+yQpqwmNzrVcUkSGM84ff2pClfVzx1h+1+ClERhS5ZHdCyEyIfBANrAS11E0atShpo6CRmJ4Yyq14RKQqjnWdoISI357wq5eSu0uRGKjxrMWFl+wgOjabnIUZvlrUM8/iaQtEsie5XvR6DJsUn+cLXmbukk1KukldNl3odyEnxjhzhIGpQmqIhITNAiexG3iyPxTNuAXRJMopkuI6+bzwxV6r9PQNaSd2Cyf1idT1AIG2skzvXoVunMPymEoDTqf2s/ih0cdnKC1MKxxvlaPOqtmp1+vbzsjXxia7+HgUd+kYGY5IlkczytCXbc3DgghaYyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:52:50.6872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e875beb6-f769-4fce-ca9b-08de62cf5208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348

This patch series enables CXL protocol error handling for both CXL Ports
and CXL Endpoints (EP). The previous revision can be found here:
https://lore.kernel.org/linux-cxl/20260114182055.46029-1-terry.bowman@amd.com/

The base for this series is: 9a8920ca8ebf (for-7.0/cxl-aer-prep) +
376e2f17f3fc (Dan's v2 series).[1]

This introduces CXL error handling as an error plane implemented on top of
the existing PCIe AER handling. The CXL handling relies on the alternate
protocol training and pcie_is_cxl() to properly decode the error type and
forward the CXL protocol error to the cxl_core driver via a kfifo.

The cxl_core driver then dequeues the work (containing the CXL protocol
error details) from the kfifo. The correctable (CE) or uncorrectable (UCE)
handler is called for handling and logging. This all follows a similar flow
as the AER driver.

PCIe AER CE and UCE callback handling changes are also required. The CXL
PCIe CE handler is unnecessary and can be removed because the AER driver
already provides the handling and logging. Update the PCIe UCE handler to
return the correct pcie_ers_result_t based on the AER status and remove
the unnecessary logging.

== Patch Details==

The first patch introduces the AER-CXL kfifo instance and all the
required related kfifo changes.

Patch#2 adds serial value to the RAS trace log. It also updates
the parameter list for using with CXL Port devices.

Patch#3 introduces PCI_ERS_RESULT_PANIC. This version does not
use merge_result() and avoids the related exporting. This series only
handles and logs for the erroring device and does not iterate the topology.

Patch#4 dequeues work from the AER-CXL kfifo.

Patch#5 adds infrastructure directing CXL protocol errors to correctable
or uncorrectable handlers.

Patch#6 updates the 2 CXL RAS handlers to include handling and logging
for CXL Port devices.

Patch#7 updates the UCE handler to 'handle' the AER status.

Patch#8 removes the PCIe AER CE handler because the handling and
logging is already performed by AER driver.

== Notes ==
One side effect to note is an EP or USP fatal UCE will be handled by
CXL AER callbacks instead of CXL protocol handler callbacks. This is
because the upstream link is in an unknown state preventing accessing the
device's AER capability. Without the AER info onhand the AER driver
assumes the error is an AER error. Another patch series is in-flight
addressing this and adds a link validity check in the AER driver:
https://lore.kernel.org/linux-pci/20260124074557.73961-1-xueshuai@linux.alibaba.com/

Dan's related series addressing RAS setup has more details.[1]

[1] cxl/port: Unify RAS setup across port types
    https://lore.kernel.org/linux-cxl/20260131000403.2135324-1-dan.j.williams@intel.com/

== Testing ==
Below are the testing results while using QEMU. The QEMU testing uses a
CXL Root Port, CXL Upstream Switch Port, CXL Downstream Switch Port and CXL
Endpoint as given below. I've attached the QEMU startup commandline used.
This testing uses protocol error injection at all the devices.

The sub-topology for the QEMU testing is:
                    ---------------------
                    | CXL RP - 0C:00.0  |
                    ---------------------
                              |
                    ---------------------
                    | CXL USP - 0D:00.0 |
                    ---------------------
                              |
                    ---------------------
                    | CXL DSP - 0E:00.0 |
                    ---------------------
                              |
                    ---------------------
                    | CXL EP - 0F:00.0  |
                    ---------------------

 root@tbowman-cxl:~# lspci -t
 -+-[0000:00]- -00.0
  |           +-01.0
  |           +-02.0
  |           +-03.0
  |           +-1f.0
  |           +-1f.2
  |           \-1f.3
  \-[0000:0c]---00.0-[0d-0f]----00.0-[0e-0f]----00.0-[0f]----00.0

 The topology was created with:
     ${qemu} -boot menu=on \
            -cpu host \
            -nographic \
            -monitor telnet:127.0.0.1:1234,server,nowait \
            -M virt,cxl=on \
            -chardev stdio,id=s1,signal=off,mux=on -serial none \
            -device isa-serial,chardev=s1 -mon chardev=s1,mode=readline \
            -machine q35,cxl=on \
            -m 16G,maxmem=24G,slots=8 \
            -cpu EPYC-v3 \
            -smp 32 \
            -accel kvm \
            -drive file=${img},format=raw,index=0,media=disk \
            -device e1000,netdev=user.0 \
            -netdev user,id=user.0,hostfwd=tcp::5555-:22 \
            -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
            -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
            -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
            -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa1.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M \
            -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
            -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
            -device cxl-upstream,bus=root_port0,id=us0 \
            -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
            -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-vmem0 \
            -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
            -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-vmem1 \
            -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
            -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-vmem2 \
            -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
            -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-vmem3 \
            -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k

=== Root Port ===
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr
cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 176 Comm: kworker/26:0 Tainted: G            E       6.19.0-rc5-00036-g95c8d7385a48 #776 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_proto_err_work_fn+0x430/0x440 [cxl_core]
 process_one_work+0x22b/0x600
 worker_thread+0x195/0x350
 kthread+0x119/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

=== Upstream Switch Port ===
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
pcieport 0000:0c:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0x50/0x80
pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem0: restart CXL.mem after slot reset
cxl_pci 0000:10:00.0: mem1: restart CXL.mem after slot reset
cxl_pci 0000:11:00.0: mem3: restart CXL.mem after slot reset
cxl_pci 0000:12:00.0: mem2: restart CXL.mem after slot reset
cxl_pci 0000:0f:00.0: mem0: error resume successful
cxl_pci 0000:10:00.0: mem1: error resume successful
cxl_pci 0000:11:00.0: mem3: error resume successful
cxl_pci 0000:12:00.0: mem2: error resume successful
pcieport 0000:0c:00.0: AER: device recovery successful

=== Dowstream Switch Port ===
root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr
cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 274 Comm: kworker/26:1 Tainted: G            E       6.19.0-rc5-00036-g95c8d7385a48 #776 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_proto_err_work_fn+0x430/0x440 [cxl_core]
 process_one_work+0x22b/0x600
 worker_thread+0x195/0x350
 kthread+0x119/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

=== Endpoint ===
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/0000a000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0f:00.0 host=0000:0e:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
pcieport 0000:0e:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0x50/0x80
pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem0: error resume successful
pcieport 0000:0e:00.0: AER: device recovery

== Changes ==

Changes in v14->v15:
 PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
 - Move pci_dev_get() call to this patch (Dave)
 cxl: Update CXL Endpoint tracing
 - Update commit message
 - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (Terry)
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - None
 PCI/AER: Dequeue forwarded CXL error
 - Move pci_dev_get() to cxl_forward_error() (Dave)
 - Move in is_cxl_error() change from later patch (Terry)
 PCI: Establish common CXL Port protocol error flow
 - Update commit message and title. Added Bjorn's ack.
 - Move CE and UCE handling logic here (Terry)
 cxl: Update error handlers to support CXL Port protocol errors
 - New commit (Terry)
 cxl: Update Endpoint AER uncorrectable handler
 - Title update (Terry)
 - Change cxl_pci_error-detected() to handle & log AER (Terry)
 - Update commit message (Terry)
 - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
 cxl: Remove Endpoint AER correctable handler
 - Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
   in the AER driver. (Dan)
 - Update commit message (Terry)
 cxl: Enable CXL protocol error reporting
 - Update commit title's prefix (Bjorn)

Changes in v13->v14:
 PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Jonathan's and Dan's review-by
 - Update commit title prefix (Bjorn)
 - Revert format fix for cxl_sbr_masked() (Jonathan)
 - Update 'Compute Express Link' comment block (Jonathan)
 - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
   used (Jonathan)
 - Removed stray change (Bjorn)
 PCI: Update CXL DVSEC definitions
 - New patch. Split from previous patch such that there is now a separate
   move patch and a format fix patch.
 - Formatting update requested (Bjorn)
 - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
   PCI_DVSEC_HEADER1_LEN() (Bjorn)
 - Add Dan's review-by
 PCI: Introduce pcie_is_cxl()
 - Move FLEXBUS_STATUS DVSEC here (Jonathan)
 - Remove check for EP and USP (Dan)
 - Update commit message (Bjorn)
 - Fix writing past 80 columns (Bjorn)
 - Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)
 PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
 - New commit
 cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
 - Add sign-off for Dan and Jonathan
 - Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
 - Remove default value for CXL_RCH_RAS (Dan)
 - Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
 - Add linux/types.h include in ras_rch.c (Jonathan)
 - Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)
 PCI/AER: Export pci_aer_unmask_internal_errors
 - New commit. Bjorn requested separating out and adding immediatetly
   before being used. This is called from cxl_rch_enable_rcec() in
   following patch.
 PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
 - New commit
 PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
 - Add review-by and signed-off for Dan
 - Commit message fixup (Dan)
 - Update commit message with use-case description (Dan, Lukas)
 - Make cxl_error_is_native() static (Dan)
 - Make is_internal_error() non-static, non-export (Terry)
 PCI/AER: Use guard() in cxl_rch_handle_error_iter()
 - Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
 - Remove cleanup.h (Jonathan)
 - Reverted comment removal (Bjorn)
 - Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)
 PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
 - New commit
 PCI/AER: Report CXL or PCIe bus type in AER trace logging
 - Merged with Dan's commit. Changes are moving bus_type the last
   parameter in function calls (Dan)
 - Removed all DCOs because of changes (Terry)
 - Update commit message (Bjorn)
 - Add Bjorn's ack-by
 PCI/AER: Update struct aer_err_info with kernel-doc formatting
 - New commit
 cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
 - New commit
 cxl/port: Remove "enumerate dports" helpers
 - New commit
 cxl/port: Fix devm resource leaks around with dport management
 - New commit
 cxl/port: Move dport operations to a driver event
 - New commit
 cxl/port: Move dport RAS reporting to a port resource
 - New commit
 cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Correct message spelling (Terry)
 cxl/port: Move endpoint component register management to cxl_port
 - Correct message spelling (Terry)
 cxl/port: Map Port component registers before switchport init
 - Updates to use cxl_port_setup_regs() (Dan)
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - Add reviewed-by for Jonathan and Dave Jiang
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - Add review-by for Dan
 - Update Title prefix (Bjorn)
 - Removed merge_result. Only logging error for device reporting the
   error (Dan)
 - Remove PCI_ERS_RESULT_PANIC paragraph in pci-error-recovery.rst (Bjorn)
 PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
 - Replaced workqueue_types.h include with 'struct work_struct'
   predeclaration (Bjorn)
 - Update error message (Bjorn)
 - Reordered 'struct cxl_proto_err_work_data' (Bjorn)
 - Remove export of cxl_error_is_native() here (Bjorn)
 cxl/port: Unify endpoint and switch port lookup
 - New patch
 PCI/AER: Dequeue forwarded CXL error
 - Update commit title's prefix (Bjorn)
 - Add pdev ref get in AER driver before enqueue and add pdev ref put in
   CXL driver after dequeue and handling (Dan)
 - Removed handling to simplify patch context (Terry)
 PCI: Introduce CXL Port protocol error handlers
 - Add Dave Jiang's review-by
 - Update commit message & headline (Bjorn)
 - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
   one line (Jonathan)
 - Remove cxl_walk_port(). Only log the erroring device. No port walking. (Dan)
 - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
   sufficient (Dan)
 - Remove device_lock_if()
 - Combine CE and UCE here (Terry)
 cxl: Update Endpoint uncorrectable protocol error handling
 - Update commit headline (Bjorn)
 - Rename pci_error_detected()/pci_cor_error_detected() ->
   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
 - Remove now-invalid comment in cxl_error_detected() (Jonathan)
 - Split into separate patches for UCE and CE (Terry)
 cxl: Update Endpoint correctable protocol error handling
 - New commit
 - Change cxl_cor_error_detected() parameter to &pdev->dev device from
   memdev device. (Terry)
 cxl: Enable CXL protocol errors during CXL Port probe
 - Update commit title's prefix (Bjorn)

 Changes in v12->v13:
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Dave Jiang's reviewed-by
 - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
   message. (Jonathan)
 PCI/CXL: Introduce pcie_is_cxl()
 - Add Ben's "reviewed-by"
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 - None
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - None
 cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core
 - None
 cxl: Move CXL driver's RCH error handling into core/ras_rch.c
 - None
 CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
 - New patch
 CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
 - Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 - Changed copyright date from 2025 to 2023 (Jonathan)
 - Add David Jiang's, Jonathan's, and Ben's review-by
 - Readd 'struct aer_err_info' (Bot)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicated aer_err_info inline comments. Is already in the
   kernel-doc header (Ben)
 cxl/pci: Update RAS handler interfaces to also support CXL Ports
 - None
 cxl/pci: Log message if RAS registers are unmapped
 - Added Bens review-by
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Added Dave Jiang's review-by
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Add Ben's review-by
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Change as result of dport delay fix. No longer need switchport and
 endport approach. Refactor. (Terry)
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
 - Add Dave Jiang's, Jonathan's, Ben's review-by
 - Typo fix (Ben)
 CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
 - Add Dave Jiang's review-by
 - Update error message (Ben)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
 - Add Dave Jiang's review-by.
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - New patch
cxl/pci: Introduce CXL protocol error handlers for endpoints
 - Updated all the implemetnation and commit message. (Terry)
 - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
   pdev (Dave Jiang)
CXL/PCI: Introduce CXL Port protocol error handlers
 - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
   patch (Terry)
 - Remove EP case in cxl_get_ras_base(), not used. (Terry)
 - Remove check for dport->dport_dev (Dave)
 - Remove whitespace (Terry)
PCI/AER: Dequeue forwarded CXL error
 - Rewrite cxl_handle_proto_error() and cxl_proto_err_work_fn() (Terry)
 - Rename get_cxl_host dev() to be get_cxl_port() (Terry)
 - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
 - Change pr_err() calls to ratelimited. (Terry)
 - Update commit message. (Terry)
 - Remove namespace qualifier from pcie_clear_device_status()
   export (Dave Jiang)
 - Move locks into cxl_proto_err_work_fn() (Dave)
 - Update log messages in cxl_forward_error() (Ben)
CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - Renamed pci_ers_merge_result() to pcie_ers_merge_result().
   pci_ers_merge_result() is already used in eeh driver. (Bot)
CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - Rewrite report_error_detected() and cxl_walk_port (Terry)
 - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
 - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
   cxl_handle_proto_error() (Terry)
 - Remove unnecessary check for endpoint port. (Dave Jiang)
 - Remove check for RCIEP EP in cxl_report_error_detected() (Terry)
CXL/PCI: Enable CXL protocol errors during CXL Port probe
 - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
 - Add Dave Jiang's and Ben's review-by
CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Added dev and dev_is_pci() checks in cxl_mask_proto_interrupts() (Terry)

Changes in v11 -> v12:
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  - Added Dave Jiang's review by
  - Moved to front of series
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
  - Add reviewed-by for Alejandro & Dave Jiang
  - Moved to front of series
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
  - Update CONFIG_CXL_RAS in CXL Kconfig to have CXL_PCI dependency (Terry)
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
  - Added review-by for Sathyanarayanan
  - Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
    this backwards into this patch.
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditio
  - Moved CXL_RCH_RAS Kconfig definition here from following commit
 CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
  - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
  - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  - Change formatting to be same as existing definitions
  - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
 PCI/CXL: Introduce pcie_is_cxl()
  - Add review-by for Alejandro
  - Add comment in set_pcie_cxl() explaining why updating parent status.
 PCI/AER: Report CXL or PCIe bus error type in trace logging
  - Change aer_err_info::is_cxl to be bool a bitfield. Update structure padding. (Lukas)
  - Add kernel-doc for 'struct aer_err_info' (Lukas)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  - Correct parameters to call trace_cxl_aer_correctable_error() (Shiju)
  - Add reviewed-by for Jonathan and Shiju
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
  - RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
  - Documentation requested by (Lukas)
 CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL errors
  - Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
  - New patch
 PCI/AER: Dequeue forwarded CXL error
  - Add guard for CE case in cxl_handle_proto_error() (Dave)
  - Updated commit message (Terry)
 CXL/PCI: Introduce CXL Port protocol error handlers
  - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
    pci_to_cxl_dev() (Lukas)
  - Change cxl_error_detected() -> cxl_cor_error_detected() (Terry)
  - Remove NULL variable assignments (Jonathan)
  - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
    port searches. (Dave)
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
    Is not needed. (Lukas)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  - Clean up port discovery in cxl_do_recovery() (Dave)
  - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10 -> v11:
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 - New patch
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
 - New patch
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - New patch
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
 - New patch
 CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
 - Remove changes in code-split and move to earlier, new patch
 - Add #include <linux/bitfield.h> to cxl_ras.c
 - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
   to aer.h, more localized.
 - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - New patch
 PCI/CXL: Introduce pcie_is_cxl()
 - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
   downstream port by calling set_pcie_cxl(). (Dan)
 - Retitle patch: 'Add' -> 'Introduce'
 - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
 CXL/AER: Update PCI class code check to use FIELD_GET()
 - Add #include <linux/bitfield.h> to cxl_ras.c (Terry)
 - Removed line wrapping at "(CXL 3.2, 8.1.12.1)". (Jonathan)
 cxl/pci: Log message if RAS registers are unmapped
 - Added Dave Jiang's review-by (Terry)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Updated CE and UCE trace routines to maintian consistent TP_Struct ABI
   and unchanged TP_printk() logging. (Shiju, Alison)
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Added Dave Jiang and Jonathan Cameron's review-by
 - Changes moved to core/ras.c
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
 - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
 - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
   and cxl_switch_port_init_ras() (Dave Jiang)
 - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
 cxl/pci: Introduce CXL Endpoint protocol error handlers
 - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
 - cxl_error_detected() - Remove extra line (Shiju)
 - Changes moved to core/ras.c (Terry)
 - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
 - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
 - Move #include "pci.h from cxl.h to core.h (Terry)
 - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
 CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
 - Move RCH implementation to cxl_rch.c and RCH declarations to pci/pci.h. (Terry)
 - Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
   and work struct. (Dan)
 - Remove embedded struct from cxl_proto_err_work (Dan)
 - Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
 - Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
   not registered for workqueue. (Dan)
 PCI/AER: Dequeue forwarded CXL error
 - Reword patch commit message to remove RCiEP details (Jonathan)
 - Add #include <linux/bitfield.h> (Terry)
 - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
 - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
 - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
 - Usse FIELD_GET() in discovering class code (Jonathan)
 - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
 CXL/PCI: Introduce CXL Port protocol error handlers
 - Removed check for PCI_EXP_TYPE_RC_END in cxl_report_error_detected() (Terry)
 - Update is_cxl_error() to check for acceptable PCI EP and port types
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - pci_ers_merge_result() - Change export to non-namespace and rename
   to be pci_ers_merge_result() (Jonathan)
 - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result (Terry)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - pci_ers_merge_results() - Move to earlier patch
 CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Remove guard() in cxl_mask_proto_interrupts(). Observed device lockup/block
   during testing. (Terry)

Changes in v9 -> v10:
 - Add drivers/pci/pcie/cxl_aer.c
 - Add drivers/cxl/core/native_ras.c
 - Change cxl_register_prot_err_work()/cxl_unregister_prot_err_work to return void
 - Check for pcie_ports_native in cxl_do_recovery()
 - Remove debug logging in cxl_do_recovery()
 - Update PCI_ERS_RESULT_PANIC definition to indicate is CXL specific
 - Revert trace logging changes: name,parent -> memdev,host.
 - Use FIELD_GET() to check for EP class code (cxl_aer.c & native_ras.c).
 - Change _prot_ to _proto_ everywhere
 - cxl_rch_handle_error_iter(), check if driver is cxl_pci_driver
 - Remove cxl_create_prot_error_info(). Move logic into forward_cxl_error()
 - Remove sbdf_to_pci() and move logic into cxl_handle_proto_error()
 - Simplify/refactor get_pci_cxl_host_dev()
 - Simplify/refactor cxl_get_ras_base()
 - Move patch 'Remove unnecessary CXL Endpoint handling helper functions' to front
 - Update description for 'CXL/PCI: Introduce CXL Port protocol error
   handlers' with why state is not used to determine handling
 - Introduce cxl_pci_drv_bound() and call from cxl_rch_handle_error_iter()

 Changes in v8 -> v9:
 - Updated reference counting to use pci_get_device()/pci_put_device() in
   cxl_disable_prot_errors()/cxl_enable_prot_errors
 - Refactored cxl_create_prot_err_info() to fix reference counting
 - Removed 'struct cxl_port' driver changes for error handler. Instead
   check for CXL device type (EP or Port device) and call handler
 - Make pcie_is_cxl() static inline in include/linux/linux.h
 - Remove NULL check in create_prot_err_info()
 - Change success return in cxl_ras_init() to use hardcoded 0
 - Changed 'struct work_struct cxl_prot_err_work' declaration to static
 - Change to use rate limited log with dev anchor in forward_cxl_error()
 - Refactored forward-cxl_error() to remove severity auto variable
 - Changed pci_aer_clear_nonfatal_status() to be static inline for
   !(CONFIG_PCIEAER)
 - Renamed merge_result() to be cxl_merge_result()
 - Removed 'ue' condition in cxl_error_detected()
 - Updated 2nd parameter in call to __cxl_handle_cor_ras()/__cxl_handle_ras()
   in unify patch
 - Added log message for failure while assigning interrupt disable callback
 - Updated pci_aer_mask_internal_errors() to use pci_clear_and_set_config_dword()
 - Simplified patch titles for clarity
 - Moved CXL error interrupt disabling into cxl/core/port.c with CXL Port
 teardown
 - Updated 'struct cxl_port_err_info' to only contain sbdf and severity
 Removed everything else.
 - Added pdev and CXL device get_device()/put_device() before calling handlers

Changes in v7 -> v8:
 [Dan] Use kfifo. Move handling to CXL driver. AER forwards error to CXL
 driver
 [Dan] Add device reference incrementors where needed throughout
 [Dan] Initiate CXL Port RAS init from Switch Port and Endpoint Port init
 [Dan] Combine CXL Port and CXL Endpoint trace routine
 [Dan] Introduce aer_info::is_cxl. Use to indicate CXL or PCI errors
 [Jonathan] Add serial number for all devices in trace
 [DaveJ] Move find_cxl_port() change into patch using it
 [Terry] Move CXL Port RAS init into cxl/port.c
 [Terry] Moved kfifo functions into cxl/core/ras.c

Changes in v6 -> v7:
 [Terry] Move updated trace routine call to later patch. Was causing build
 error.

Changes in v5 -> v6:
 [Ira] Move pcie_is_cxl(dev) define to a inline function
 [Ira] Update returning value from pcie_is_cxl_port() to bool w/o cast
 [Ira] Change cxl_report_error_detected() cleanup to return correct bool
 [Ira] Introduce and use PCI_ERS_RESULT_PANIC
 [Ira] Reuse comment for PCIe and CXL recovery paths
 [Jonathan] Add type check in for cxl_handle_cor_ras() and cxl_handle_ras()
 [Jonathan] cxl_uport/dport_init_ras_reporting(), added a mutex.
 [Jonathan] Add logging example to patches updating trace output
 [Jonathan] Make parameter 'const' to eliminate for cast in match_uport()
 [Jonathan] Use __free() in cxl_pci_port_ras()
 [Terry] Add patch to log the PCIe SBDF along with CXL device name
 [Terry] Add patch to handle CXL endpoint and RCH DP errors as CXL errors
 [Terry] Remove patch w USP UCE fatal support @ aer_get_device_error_info()
 [Terry] Rebase to cxl/next commit 5585e342e8d3 ("cxl/memdev: Remove unused partition values")
 [Gregory] Pre-initialize pointer to NULL in cxl_pci_port_ras()
 [Gregory] Move AER driver bus name detection to a static function

Changes in v4 -> v5:
 [Alejandro] Refactor cxl_walk_bridge to simplify 'status' variable usage
 [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
 [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
 [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
 [Ming] Use port->dev for call to devm_add_action_or_reset() in
 cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
 [Jonathan] Use get_device()/put_device() to prevent race condition in
 cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Commit message cleanup. Capitalize keywords from CXL and PCI
 specifications

Changes in v3 -> v4:
 [Lukas] Capitalize PCIe and CXL device names as in specifications
 [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
 [Lukas] Correct namespace spelling
 [Lukas] Removed export from pcie_is_cxl_port()
 [Lukas] Simplify 'if' blocks in cxl_handle_error()
 [Lukas] Change panic message to remove redundant 'panic' text
 [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
 [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
 [Terry] Added field description for cxl_err_handlers in pci.h comment block

Changes in v1 -> v2:
 [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
 [Jonathan] Update description to DSP map patch description
 [Jonathan] Update cxl_pci_port_ras() to check for NULL port
 [Jonathan] Dont call handler before handler port changes are present (patch order)
 [Bjorn] Fix linebreak in cover sheet URL
 [Bjorn] Remove timestamps from test logs in cover sheet
 [Bjorn] Retitle AER commits to use "PCI/AER:"
 [Bjorn] Retitle patch#3 to use renaming instead of refactoring
 [Bjorn] Fix base commit-id on cover sheet
 [Bjorn] Add VH spec reference/citation
 [Terry] Removed last 2 patches to enable internal errors. Is not needed
 because internal errors are enabled in AER driver.
 [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
 [Dan] Use kernel panic in CXL recovery
 [Dan] cxl_port_hndlrs -> cxl_port_error_handlers

Terry Bowman (9):
  PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
  cxl: Update CXL Endpoint tracing
  PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
  PCI/AER: Dequeue forwarded CXL error
  PCI: Establish common CXL Port protocol error flow
  cxl: Update error handlers to support CXL Port protocol errors
  cxl: Update Endpoint AER uncorrectable handler
  cxl: Remove Endpoint AER correctable handler
  cxl: Enable CXL protocol error reporting

Terry Bowman (9):
  PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
  cxl: Update CXL Endpoint tracing
  PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
  PCI/AER: Dequeue forwarded CXL error
  PCI: Establish common CXL Port protocol error flow
  cxl: Update error handlers to support CXL Port protocol errors
  cxl: Update Endpoint AER uncorrectable handler
  cxl: Remove Endpoint AER correctable handler
  cxl: Enable CXL protocol error reporting

 Documentation/PCI/pci-error-recovery.rst |   2 +
 drivers/cxl/core/core.h                  |  18 +-
 drivers/cxl/core/port.c                  |   8 +-
 drivers/cxl/core/ras.c                   | 336 +++++++++++++++++++----
 drivers/cxl/core/ras_rch.c               |   6 +-
 drivers/cxl/core/trace.h                 |  21 +-
 drivers/cxl/cxlpci.h                     |  15 +-
 drivers/cxl/pci.c                        |   7 +-
 drivers/pci/pci.c                        |   1 +
 drivers/pci/pci.h                        |   2 -
 drivers/pci/pcie/Makefile                |   1 +
 drivers/pci/pcie/aer.c                   |  16 +-
 drivers/pci/pcie/aer_cxl_vh.c            |  82 ++++++
 drivers/pci/pcie/portdrv.h               |   4 +
 include/linux/aer.h                      |  24 ++
 include/linux/pci.h                      |   5 +
 16 files changed, 444 insertions(+), 104 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

Uses 9a8920ca8ebf (cxl/for-7.0/cxl-aer-prep) +
376e2f17f3fca84bf5a2e707d0c47ba22665df6d Dans series as prerequisite

base-commit: 376e2f17f3fca84bf5a2e707d0c47ba22665df6d
-- 
2.34.1

