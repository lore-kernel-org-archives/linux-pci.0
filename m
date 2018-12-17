Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3FC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B52146F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeLQRa3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:30:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbeLQRa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:30:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHHSRVm126817
        for <linux-pci@vger.kernel.org>; Mon, 17 Dec 2018 12:30:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pefw31203-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 17 Dec 2018 12:30:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Mon, 17 Dec 2018 17:30:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 17:30:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHHUKGF131406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 17:30:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76C8A52054;
        Mon, 17 Dec 2018 17:30:20 +0000 (GMT)
Received: from sig-9-145-45-130.uk.ibm.com (unknown [9.145.45.130])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8B20D52052;
        Mon, 17 Dec 2018 17:30:19 +0000 (GMT)
Date:   Mon, 17 Dec 2018 18:30:18 +0100 (CET)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Christoph Hellwig <hch@infradead.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] s390/pci: handle function enumeration after sriov
 enablement
In-Reply-To: <20181214131802.GA13950@infradead.org>
References: <20181212215453.GJ99796@google.com> <20181213175428.87520-2-sebott@linux.ibm.com> <20181214131245.GB2606@infradead.org> <20181214131802.GA13950@infradead.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18121717-0012-0000-0000-000002DA5F35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121717-0013-0000-0000-0000210FF450
Message-Id: <alpine.LFD.2.21.1812171806330.28490@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Dec 2018, Christoph Hellwig wrote:
> On Fri, Dec 14, 2018 at 05:12:45AM -0800, Christoph Hellwig wrote:
> > On Thu, Dec 13, 2018 at 06:54:28PM +0100, Sebastian Ott wrote:
> > > Implement pcibios_sriov_{add|del}_vfs as empty functions. VF
> > > creation will be triggered by the hotplug code.
> > 
> > And instead of having the arch suplply a no-op arch override I
> > think it would be better to have the config option just stub it
> > out in common code.
> 
> Or in fact maybe even a runtime flag in struct pci_dev.  Who knows
> if all future s390 PCIe busses will have exactly the same behavior
> or if we eventually get the standards compliant behvior back?

Something like this:
https://lore.kernel.org/linux-pci/20181212215453.GJ99796@google.com/T/#m649d86ea3c65f669c74d048f89afbaf473876ac3

Not a runtime flag, but a function pointer in struct pci_host_bridge.
This would provide the requested flexibility. The problem with this
approach is that it requires other patches that are not yet upstream
(https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=pci-probe-rework).

Since this discussion is going on since a few months and I want to
have this code upstream and in distributions for HW enablement I've
asked Bjorn to go with the initial approach (weak functions) and
promised to move that to struct pci_host_bridge once Arnd's patches
are upstream. Would that be OK for you too?

Regards,
Sebastian

