Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DFFC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 19:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A7E20820
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 19:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rY703zTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDJTtW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:49:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35808 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJTtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 15:49:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AJnFp6187515;
        Wed, 10 Apr 2019 19:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=DwyGwEO0U+I2N3kX3NzhFDAcCmkCURqVtLyacNoPvKE=;
 b=rY703zTbU2gTyXTmDePanoftxbUy215+wXcguFluUdzxrKcOCRCC9Is6dvC38fRyLq5I
 p3Ms15jpyM98PzaiZCNVPZg6vnDL/dQn/bpX6nsrimwCE1nxbnr8NegxUtgnRp4OAtOs
 X1ahQNhnHzgd2U9BSaKPEoU3RFnl3EgzeN6dczGIbRSUstIJpHBPqKCASw/STmJKFgnz
 XRFrZapjqzP6Hwd792x64mVLnrkkk/i1liq4CVnW5jRcRpeL3la8okP8phJ3hlGD5H+5
 tLysMj/jAvAg66a8aYRhMGYvE/xnM/6FRIxt4VZMKXWdMNJ9LTMvAycrITVM0KWCzJBv 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphmenauw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 19:49:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AJmUrC161475;
        Wed, 10 Apr 2019 19:49:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rph7td4uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 19:49:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AJnCEH028473;
        Wed, 10 Apr 2019 19:49:12 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 12:49:12 -0700
Date:   Wed, 10 Apr 2019 22:49:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Grant Likely <grant.likely@linaro.org>
Subject: [pci:pci/enumeration 6/6] drivers/pci/of.c:40 pci_set_bus_of_node()
 error: we previously assumed 'bus->self' could be null (see line 34)
Message-ID: <20190410194901.GE31633@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100129
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100129
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
head:   60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
commit: 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7 [6/6] PCI: OF: Support "external-facing" property

smatch warnings:
drivers/pci/of.c:40 pci_set_bus_of_node() error: we previously assumed 'bus->self' could be null (see line 34)

# https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git remote update pci
git checkout 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
vim +40 drivers/pci/of.c

98d9f30c82 Benjamin Herrenschmidt 2011-04-11  31  
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  32  void pci_set_bus_of_node(struct pci_bus *bus)
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  33  {
98d9f30c82 Benjamin Herrenschmidt 2011-04-11 @34  	if (bus->self == NULL)
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  35  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  36  	else
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  37  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  38  
60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  39  	if (of_get_property(bus->dev.of_node, "external-facing", NULL))
60ea7f5dd9 Jean-Philippe Brucker  2019-04-02 @40  		bus->self->untrusted = true;
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  41  }
98d9f30c82 Benjamin Herrenschmidt 2011-04-11  42  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
