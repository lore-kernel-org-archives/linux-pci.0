Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157033987F;
	Tue, 17 Mar 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740840; cv=none; b=aIX8F+Qd4CV2eCLPsmVJ4v5ahxfOKOCyYlJ9W7NdizATctzGDDBoKIeTf4I6E/yEl6WfBgOHfSsnFq6vV8JAZVTFOXHrY72cKeo63exKzYRyjawzQjCJV7eFNlxFSzm5VYsFOONE3qA0M/Y1UE8cRxNok3NsoXES0GR33T8c4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740840; c=relaxed/simple;
	bh=3INUUjHSzlSVYu2IiUfPDJYyFvRZld0ufEiZLl+ytOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfhdPgTjerB50j6jys38MzNBGjL7Kw8knSVQZla4okYwG/Nm3yWA+va3khC8SPjQ2A0ac0PpFQrM3fd6K2dqrt7PVFt3YBMZoJKxXjUnd+VD6FmHnGvEiC+p78ArtzA7paiGbUcGfaZ1UYJCzrth6IZdzieA5J13SSLAOttmmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n5vn1/sh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n5vn1/sh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8JWk8651331;
	Tue, 17 Mar 2026 09:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=psv4n3br+LREFPOkh902APQeIxlpTpohnsPsPiJYmck=; b=n5vn1/shSYya
	FDPsztDGO7UgqY3IRVkTSagWLD40hM8uRoJaSDZOltRTNh3FbzYa5sikEC5WKEAj
	5WEbNkwzwNWH+VHNmsNjALESR08lVKTwTwMQstqiNl/CxMoF/0Y09Gk2LfMcZlq6
	hmKEWfMDP98Jthah+TC7j7SIHQH+RJXse2WwQf8AsgqabuIU9MPUJqKQrcGJaZlU
	mK4D9IItZpRftBQwpnOIZFeD2YE/l77kQQX/WrZ5VTw/wkumayGQnWqyPzjiCjaF
	qxZmb8fJ2IPMvw1QWeqZzayT1+S+TE5tf30C/TyKzATJEOM7Kk7XGT0Vz4FTAb/X
	woXYxagk2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cuka1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 09:47:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7LJWq015676;
	Tue, 17 Mar 2026 09:47:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n8h0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 09:47:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H9kvrI29425962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:46:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1381A2004B;
	Tue, 17 Mar 2026 09:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD1720040;
	Tue, 17 Mar 2026 09:46:56 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.87.138.51])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Mar 2026 09:46:56 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w2R0q-000000068QL-1t2A;
	Tue, 17 Mar 2026 10:46:56 +0100
Date: Tue, 17 Mar 2026 10:46:56 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Benjamin Block <lkml@mageta.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <20260317094656.GI2161595@p1gen4-pw042f0m>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
 <20260317090149.GA3835708@chlorum.ategam.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317090149.GA3835708@chlorum.ategam.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b92316 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ET4UGBf4cUOmNW3N-FYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4NSBTYWx0ZWRfX4xH9hYmJCvAc
 WSLCXFb+JiMvcJe2u5no0hRYefogmge4dUsdIwBvWyAVkYLIEHlyT48CdWjLgKAaI7PPhQ1o7O6
 YI0swuLmdzejHSKIosjbvHY6ByA/bix/a8gubejXsuFdxyBskrz8jC48eJqF5NrjyHqsRTnjiSt
 9JE+1d7b9IgnDB55wQqWSTRSr6SUCWXrWqWIo61Z9Ng8i8iPBCaBy8pIPYV+VtZJ097e1whBJAc
 zG59RIhX/+gzoJ0jm2U1EZ18X40/jh4RVkaMoN5ZaJ1Fe/7eTbmWn9zhIV/pTMBoMK+b4wZneCz
 zbd5UQSK6X0/1XvdqdJpy5V+7U2ZcbxzyQY1YVDYgyrhGbTlriwg5VDiGgqRD191NWq704a2AjK
 5GRSdtERD9vE0NMgJMO4i/FCcyYmIosIcvkUIQvV2h/6tBqzqKvRzUIwJlgtJQ7w5f7qxswVc5K
 3JrbqR8/vUmKqz0pRTA==
X-Proofpoint-GUID: KHIe8_bjM-Tl4w1dkCWEpdeguNENM4t3
X-Proofpoint-ORIG-GUID: KHIe8_bjM-Tl4w1dkCWEpdeguNENM4t3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170085

On Tue, Mar 17, 2026 at 10:01:49AM +0100, Benjamin Block wrote:
> One quick idea: can we somehow unbind the device from any device driver
> in remove_store() before calling
> pci_stop_and_remove_bus_device_locked()?  That way we would not have any
> SR-IOV functions attached anymore at the point where we remove the PF,
> since the DD are expected to clean them up.

Very quick-and-dirty:

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf749ba9..490b6c1f07d3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -33,6 +33,8 @@
 #include <linux/unaligned.h>
 #include "pci.h"
 
+extern void device_driver_detach(struct device *dev);
+
 #ifndef ARCH_PCI_DEV_GROUPS
 #define ARCH_PCI_DEV_GROUPS
 #endif
@@ -518,8 +520,10 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		device_driver_detach(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,

I run this with vfio-pci as device-driver and some sniff tests:

  root@hostname:~# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1100:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1100:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  root@hostname:~# cd /sys/bus/pci/
  root@hostname:/sys/bus/pci# echo 0 > devices/1100\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# echo 1100:00:00.0 > drivers/vfio-pci/unbind
  root@hostname:/sys/bus/pci# echo 1100:00:00.0 > drivers/vfio-pci/bind
  root@hostname:/sys/bus/pci# echo 0 > devices/1100\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/remove
  root@hostname:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  root@hostname:/sys/bus/pci# rmmod vfio_ccw vfio_pci vfio_pci_core vfio_iommu_type1 vfio
  root@hostname:/sys/bus/pci# modprobe -a vfio_ccw vfio_pci vfio_pci_core vfio_iommu_type1 vfio
  root@hostname:/sys/bus/pci# echo 1 > rescan
  root@hostname:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# echo 1 > devices/1180\:00\:00.0/sriov_numvfs
  root@hostname:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1100:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1100:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)

All without any Warnings/Lockdep-Splats/Kmemleak-Splats/etc.

But the patch itself is very hacky I'm afraid.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
