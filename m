Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB957C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C8A2083B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfBUWTR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:19:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfBUWTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 17:19:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LMItFe144174
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 17:19:16 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qt4mpr2wn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 17:19:15 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 21 Feb 2019 22:19:15 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 22:19:09 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LMJ8GV17956892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:19:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 196BCAC062;
        Thu, 21 Feb 2019 22:19:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04AEFAC05F;
        Thu, 21 Feb 2019 22:19:03 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.181.131])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Feb 2019 22:19:03 +0000 (GMT)
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com> <20190123083435.x3svwqp472mdgglw@8bytes.org> <a6315ab3-bffb-7470-365d-b26df6524bda@arm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "virtio-dev\@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kevin.tian\@intel.com" <kevin.tian@intel.com>,
        "tnowicki\@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "mst\@redhat.com" <mst@redhat.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "virtualization\@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu\@lists.linux-foundation.org" 
        <iommu@lists.linux-foundation.org>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas\@google.com" <bhelgaas@google.com>,
        "frowand.list\@gmail.com" <frowand.list@gmail.com>,
        "kvmarm\@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
In-reply-to: <a6315ab3-bffb-7470-365d-b26df6524bda@arm.com>
Date:   Thu, 21 Feb 2019 19:18:59 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19022122-0060-0000-0000-0000030EDE75
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164443; UDB=6.00608083; IPR=6.00945028;
 MB=3.00025688; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 22:19:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022122-0061-0000-0000-00004860ED8E
Message-Id: <878sy8bx9o.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210152
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello Jean-Philippe,

Jean-Philippe Brucker <jean-philippe.brucker@arm.com> writes:
> Makes sense, though I think other virtio devices have been developed a
> little more organically: device and driver code got upstreamed first,
> and then the specification describing their interface got merged into
> the standard. For example I believe that code for crypto, input and GPU
> devices were upstreamed long before the specification was merged. Once
> an implementation is upstream, the interface is expected to be
> backward-compatible (all subsequent changes are introduced using feature
> bits).
>
> So I've been working with this process in mind, also described by Jens
> at KVM forum 2017 [3]:
> (1) Reserve a device ID, and get that merged into virtio (ID 23 for
> virtio-iommu was reserved last year)
> (2) Open-source an implementation (this driver and Eric's device)
> (3) Formalize and upstream the device specification
>
> But I get that some overlap between (2) and (3) would have been better.
> So far the spec document has been reviewed mainly from the IOMMU point
> of view, and might require more changes to be in line with the other
> virtio devices -- hopefully just wording changes. I'll kick off step
> (3), but I think the virtio folks are a bit busy with finalizing the 1.1
> spec so I expect it to take a while.

I read v0.9 of the spec and have some minor comments, hope this is a
good place to send them:

1. In section 2.6.2, one reads

    If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered and the range
    described by fields virt_start and virt_end doesn’t fit in the range
    described by input_range, the device MAY set status to VIRTIO_-
    IOMMU_S_RANGE and ignore the request.

Shouldn't int say "If the VIRTIO_IOMMU_F_INPUT_RANGE feature is
negotiated" instead?

2. There's a typo at the end of section 2.6.5:

    The VIRTIO_IOMMU_MAP_F_MMIO flag is a memory type rather than a
    protection lag.

s/lag/flag/

3. In section 3.1.2.1.1, the viommu compatible field says "virtio,mmio".
Shouldn't it say "virtio,mmio-iommu" instead, to be consistent with
"virtio,pci-iommu"?

4. There's a typo in section 3.3:

    A host bridge may limit the input address space – transaction
    accessing some addresses won’t reach the physical IOMMU.

s/transaction/transactions/

I also have one last comment which you may freely ignore, considering
it's clearly just personal opinion and also considering that the
specification is mature at this point: it specifies memory ranges by
specifying start and end addresses. My experience has been that this is
error prone, leading to confusion and bugs regarding whether the end
address is inclusive or exclusive. I tend to prefer expressing memory
ranges by specifying a start address and a length, which eliminates
ambiguity.

--
Thiago Jung Bauermann
IBM Linux Technology Center

