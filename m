Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C69CC43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A63420841
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 12:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A63420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJJURV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:17:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbeJJURU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Oct 2018 16:17:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ACsoLs120662
        for <linux-pci@vger.kernel.org>; Wed, 10 Oct 2018 08:55:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1eqxyvbm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 10 Oct 2018 08:55:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 10 Oct 2018 13:55:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 13:55:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9ACt8gs328022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 12:55:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C8B94C052;
        Wed, 10 Oct 2018 15:54:45 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E93ED4C059;
        Wed, 10 Oct 2018 15:54:44 +0100 (BST)
Received: from dyn-9-152-212-155.boeblingen.de.ibm.com (unknown [9.152.212.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Oct 2018 15:54:44 +0100 (BST)
Date:   Wed, 10 Oct 2018 14:55:07 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi.aag-de.ibmmobiledemo.com
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] sriov enablement on s390
In-Reply-To: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com> <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18101012-0016-0000-0000-000002112186
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101012-0017-0000-0000-00003268902E
Message-Id: <alpine.LFD.2.21.1810101451310.32089@schleppi.aag-de.ibmmobiledemo.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100130
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Wed, 12 Sep 2018, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> > On s390 we currently handle SRIOV within firmware. Which means
> > that the PF is under firmware control and not visible to operating
> > systems. SRIOV enablement happens within firmware and VFs are
> > passed through to logical partitions.
> > 
> > I'm working on a new mode were the PF is under operating system
> > control (including SRIOV enablement). However we still need
> > firmware support to access the VFs. The way this is supposed
> > to work is that when firmware traps the SRIOV enablement it
> > will present machine checks to the logical partition that
> > triggered the SRIOV enablement and provide the VFs via hotplug
> > events.
> > 
> > The problem I'm faced with is that the VF detection code in
> > sriov_enable leads to unusable functions in s390.
> 
> We're moving away from the weak function implementation style.  Can
> you take a look at Arnd's work here, which uses pci_host_bridge
> callbacks instead?
> 
>   https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de

What's the status of Arnd's patches - will they go upstream in the next
couple of versions? What about my patches that I rebased on Arnd's branch
will they be considered?

Regards,
Sebastian

