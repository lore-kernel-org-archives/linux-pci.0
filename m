Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156A7C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFCC206B7
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="fIPOuQV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFCC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeLEXsW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:22 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:29660 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727592AbeLEXsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 18:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1544053693; x=1575589693;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=9DYOD6c4FCI1LCZG1LOfMDHeU8aM71VbiEuZFeU3xGg=;
  b=fIPOuQV7w/oSLRM7laC5vdO1tvUdSqnPzPUMV3FnwnBZqmX+oTfqWfer
   1N1kfJBPxCmEAV9c21qQkG3y2YlUvIWbQm9UXGXAixCNvkADRb4/HUwb+
   tciYYz8ckG1rqZfc/KKqN1Vu+Ln66sK8NB7difEZx7yUMSf5GLZRG55hk
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5AAApYwhchyeV50NkHQEBBQEHBQG?=
 =?us-ascii?q?BUwYBCwGDazGMZ4suhAqVUIF6CwEBhGyDFCI2Bw0BAwEBAgEBAgEBAhABAQE?=
 =?us-ascii?q?KCwkIKS+CNiKCaBYoPxIBPmkEDg0agn+CApoCPQKBEIlYAQEBgh2KLowegha?=
 =?us-ascii?q?JcYUOAqBWCQWBY49SIIFMj2MsmCsCBAIEBQIUgU0EggNwgz2CNI4mQAGKa4E?=
 =?us-ascii?q?fAQE?=
X-IPAS-Result: =?us-ascii?q?A2E5AAApYwhchyeV50NkHQEBBQEHBQGBUwYBCwGDazGMZ?=
 =?us-ascii?q?4suhAqVUIF6CwEBhGyDFCI2Bw0BAwEBAgEBAgEBAhABAQEKCwkIKS+CNiKCa?=
 =?us-ascii?q?BYoPxIBPmkEDg0agn+CApoCPQKBEIlYAQEBgh2KLoweghaJcYUOAqBWCQWBY?=
 =?us-ascii?q?49SIIFMj2MsmCsCBAIEBQIUgU0EggNwgz2CNI4mQAGKa4EfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2018 17:48:12 -0600
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5Nm8Bn166191
        for <linux-pci@vger.kernel.org>; Wed, 5 Dec 2018 18:48:21 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0a-00154901.pphosted.com with ESMTP id 2p6pgh8qvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2018 18:48:20 -0500
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Dec 2018 05:48:17 +0600
X-LoopCount0: from 10.166.135.142
X-IronPort-AV: E=Sophos;i="5.56,320,1539666000"; 
   d="scan'208";a="1169291426"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>
Subject: Purpose of port_type field in PCI Express port bus driver
Thread-Topic: Purpose of port_type field in PCI Express port bus driver
Thread-Index: AQHUjPT9Cdcx5WCMtEevRRkpnDuxrg==
Date:   Wed, 5 Dec 2018 23:48:15 +0000
Message-ID: <c688f8805a5e42bc8835d7c640223937@ausx13mps321.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.194]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050208
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm not sure what the purpose of the port_type field is.=0A=
=0A=
Intuition would tell me that I fill in the pcie_port_service_driver =0A=
struct, call pcie_port_service_register(), and then I'd get my probe() =0A=
called whenever a device with a matching .port_type is found.=0A=
=0A=
But in reality, one also has to edit portdrv_core.c to create a device =0A=
that the service driver can bind to. So if there's already the need to =0A=
do work here, what is the purpose of port_type?=0A=
=0A=
Alex=0A=
