Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D305CC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782222098A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UC5WpdtH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nRE5WZAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782222098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJKXov (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:44:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35114 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbeJKXou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 19:44:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGDg86005455;
        Thu, 11 Oct 2018 09:16:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Ve3R3U1YAq4KUrFu/cOQlMnj9haRusdzqs2UVSldV3A=;
 b=UC5WpdtHrN+I4nGmche8Qlnr1kBn7/Hn0VVQT0jbdIS1BoRRfQgZ0UDss/DL/eihKprO
 0r4YEJbj/89tveOqrIJm+WW1M4ItI4dkS78tev57FDRi9rPgSOZ6wPFx5dleJyL9eXnj
 SPBhOJDdmw0QILi/GvY1OZ7l2VlsPPtjpEtxpSOrEVfrGg/8mjCf1GJ/u8S2mYbSRxOG
 7piJRnUNxvx2mgGaJDsGO7IDAsaFenukFxuW3ZGP+6+F3vi2VV9MvmPXgtkQmhlSfoZg
 6fMtNRQXF2voxFISX/6rtglLSIf6VliXC+NidNyOjitS0La8B9iCmbJ7pn3Yzgacm1vs qQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0022.outbound.protection.outlook.com [207.46.163.22])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwx7qpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Oct 2018 09:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve3R3U1YAq4KUrFu/cOQlMnj9haRusdzqs2UVSldV3A=;
 b=nRE5WZAxvTMNKo0gxaJ6RyLCXw4kH6TE4RCtMEtkrEDoz+h+E+7Q7hjSwWwpG4bqzPU/9MG1LVhJAmYfZbSaCrkUBnwAU4I+7Nw5Uqb5+TMKshtNJrFyo7EuuJZbmj/zJHahjG5KyhYB38kDwTHDxcaRZMdhk0UzJlL1hnUzWTU=
Received: from SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) by BY2PR07MB693.namprd07.prod.outlook.com
 (2a01:111:e400:2c52::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Thu, 11 Oct
 2018 16:16:41 +0000
Received: from CO1NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by SN4PR0701CA0010.outlook.office365.com
 (2603:10b6:803:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Thu, 11 Oct 2018 16:16:40 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT018.mail.protection.outlook.com (10.152.96.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Thu, 11 Oct 2018 16:16:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGGbTS031357
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:16:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 11 Oct 2018 18:16:43 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Oct 2018 18:16:43 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGGbmF001171;
        Thu, 11 Oct 2018 17:16:37 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9BGGaKN001166;
        Thu, 11 Oct 2018 17:16:36 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v4 3/4] PCI: cadence: Check whether MSI is masked before sending it
Date:   Thu, 11 Oct 2018 17:16:11 +0100
Message-ID: <1539274571-545-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(36092001)(4326008)(2906002)(26826003)(2351001)(42186006)(87636003)(16586007)(305945005)(478600001)(2616005)(86362001)(476003)(126002)(486006)(336012)(246002)(106466001)(316002)(107886003)(426003)(105596002)(54906003)(186003)(47776003)(8936002)(5660300001)(51416003)(26005)(50466002)(48376002)(7636002)(50226002)(6916009)(6666004)(8676002)(36756003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB693;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT018;1:6Zi/Y78DyPRU0kcfUujyCfGpkkuP676foaB7tfE6yfBS+ADA/mtGTodwC2eqsE3wp1urc2dGULKMW2kCER5w6lvKK3mtSwGfq/L8Uu86Fh7Udat+RalngnSoXjlDEg+x
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 468ca420-7f8a-471d-a974-08d62f94ed65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BY2PR07MB693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB693;3:ewWGNajMMGZZFJJuNiRIbhqx2Ha7GtM826Yt0ec2ZM/Tlxx4p9lmjRd7LpZRRUVB7karFjtOGVT8Gd6A9XpcDujf7ANR5hz0chT3tjyEoSUnPX3Y1LxUte6k5E7UfAz4afGltp7ZE5H6mS4Tk2nhBdP2wDA0vM6+zAxHcj7897gOS0gN4v9dISdqQbqpHdTGV/TXIQBBAYXI+HFy2I3SGdTUsq3oUbmPK6uK7zM/p8ouimmuIh8/r5WBsU/C/U2aOe+kTZvl8iS01nJDxaLM+rjhJoKiKZT5mjuAnIIkWMQExR+aFAl28mvYnIN3MREsScfU6wTXr8fiNKjBo4fGUuL60OWAbnhXBs4Ty/Pdvr8=;25:vxLfPhZwFHSrsvRZuhIAelHqAf+Ve/ALlvB/LkLOoAUOoRzgEN0EVbF/LnGJL0s0iY9TzTf1A6jal3GwRZW/5+12mPRihaRmvS7stktRTHFRuY8PiIjHFwrhNsQ/8Zo5KyB30CN88hJaarWolp9BxGk/2sKC/PW+p7ah926lft2HwU5JLeByUTVjKSZOUl/cnWTX9aI8z+BZk+5e18QUMMwvcOm+/z9k/9S2miUK0ZBxKgD0pi42/bHzXTf7cZs5aKX/QatmWvIj8ri/DHhZyqYOm+QG2xhRmml5cP66VYkgZYgeb39CxlsgZKmvZOQdQs0r3CsfdG+kJXDSLQ9QEA==
X-MS-TrafficTypeDiagnostic: BY2PR07MB693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB693;31:MIYWFvQcEnFqY4a+yZRRdo9quU4DSdAe2VbtW3f4G2gVqVoqUP19VCK6sBt0yb0faEUSyMwFDurP4c7efYgdemgeD83qvxI82AnugyUCFvIQDz3KlRn3RCCBFY59miREsmSIOz0NT8xb3TFC5rtZ7kOFXrAdtZDaPwol5pr4WFVhVJ0zboyfsQV1as9vSoRKpNsgKUKZ5iTCBkcw4ycVtcsUcGMqF9sfdtPmPll3jAM=;20:cJbm0ebAk0kkgIGESqN+dUg40jdMyDaUC+JhwBn1+ANdT4L9rQ6yw0inKhUJyieBXC8ur5Ex81OZ61HQYXkd6N2IgvhelPV1zSEpqx6eQRdWzdvgJy5pf1fB+tzBYR0sJbtGBEHI4LX5blnkI3/15oNXo1Vlj6a4x3sPglI1ma4hOdSDa2/tCTJq4cwdrs9t1RykYnrEDnGg8IHpYAFlr+pj173bqnCmf7m4NMBSGTqhP8L81yAe8gze7zg/pthRIcg5sUqOwNaVirBh/A87n3OSEQCVl2AGTXlcBQNwbf8TPhifZHK/ECs/oY5S/zjQNX/w0AFvHypFhKWEyHHgAKycBL4YpOId7HiJ/MS51Wbs8lx2RTfWTh/y7qluyIlMjGuxQaP2Pl0iDez25yVOAzqH33O22ARkFDmv+sk9ce2lY9vGUChV0lF3HCgWpVQvs7FgaGqFtj43fG9JGKSUyA1cz0ulzkZgOdV00ZnQmP2wDUfWF2kS0mT0p0brkJ+g
X-Microsoft-Antispam-PRVS: <BY2PR07MB693115AFB542A065EF33E0FD8E10@BY2PR07MB693.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR07MB693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB693;4:rsyBXa6kXaEXFTK2Qhr7S/R2uPr5SZkpSs5vZvodApFcI5jBIhmLn4Zjfc8b9DPiQm/Hkil74QuDHPqn4JIrDv2IkYz5izOzn6/AhVnR522vNUcvHYUPKXNIurE6+vGk4C9WyTHor+a3lk56+Qhrz8owTgtlRHPa7OFLpGrMQ9FFSbXQt5hqDPH0AbdKT8+eaomOfdLMpJ5Mm6WYXSCqaY5W9YXvluTFsp7YYOA5NuL8xpqndeBTgn8WCqvPq5E4JL3y4vP2mDhYc+eK4gc5TFSBmDVf8QX7iwym1v9obmngQB20oy/5/58x1pj1wtNO
X-Forefront-PRVS: 08220FA8D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB693;23:YP952DoTGkJ7YgqsbMKJtjovx+woQjUhLs5H/UBf55?=
 =?us-ascii?Q?xwVc0nVYFd4ltaUAqhDwodjnwis8pJN4gN66ImmmRSAcErxpiWXQ17lLzaA6?=
 =?us-ascii?Q?WISmIgLZ1MwMsgP/P3bRqkyTNaYbxh0hDIIvKcqxClXe9+Dx2wR/DiX+5mVN?=
 =?us-ascii?Q?+CXltQjHxdki4iBEjCJJEEVQW/d5PbAXncxf6VbC+kXB8GkTCu49sU3PsZG6?=
 =?us-ascii?Q?JH0FvAYPVD/mm2v8bwdinmcMUVGp+y5dZOO4BwBE+6BpPVzNDZquwWPPdVqV?=
 =?us-ascii?Q?3hGprshvRFMfXUoqJsQc0scUDfjgKfAlRzRbxa+AB2BPYdRqbYoANoeBeo3e?=
 =?us-ascii?Q?65+NxIUi5H05XzYXKXAU5JIeiHqmL4DRI0npFSFdkpKOMlVciCK0G9XiF8gg?=
 =?us-ascii?Q?110Rwb8UmQzdjgPSbZF6IyZnu2WFxWRsO4oYxdwMdrJeu7lEejTNlRoEK+pk?=
 =?us-ascii?Q?ZKP53BxRuAW2hXeuIUvfrdLulsLMTUTBkXabMLP2iyiB/sUrMacQ0OLPOtDv?=
 =?us-ascii?Q?ieCKrpmRJo/AUMq2/3i6sgiPKo3gKI87zblsCpnckhtsBObOjI8PoQWjh7mC?=
 =?us-ascii?Q?oac6ydOZE8t3Xl0qMTXOn5iU6tfbaq4slnqHPH2/uTE1725MDsSV0i4orzRZ?=
 =?us-ascii?Q?xolzKXsAkLHy7tNXoMR8FLE4jw1kDSppNROMFdB72b0mR+JCv/6BxrPkjKkk?=
 =?us-ascii?Q?64UonsfhSJ8WhBtlHpnp16sbkFIrXlHG6MlVVyViDiuqrtcbGi0Pl7KwyW/+?=
 =?us-ascii?Q?MkjHl7JzAffGf+u+gAmwI44xuxR7bwHmuB32xdTIqH3/78uk0/j/AAanWlLf?=
 =?us-ascii?Q?SOvQMqoYgEvw5mzGLTp7tq9eGB/9/M7S+JLmiq+PbWQ9j5Zi+2H6UOGbrXlw?=
 =?us-ascii?Q?6zmRgxLNvSSnsuXQnWzLcD/nJnnFUK4kBoYX7eFXLrq1TW4KinRonRV19MmF?=
 =?us-ascii?Q?VFYGg7/6y/+5Z+JfzmtcjWJxzK48n+FGgFnEYWcjXUfLFpWnYnIuzMKiBTxa?=
 =?us-ascii?Q?WVJWlmuU2wXzNTFCGAmTJM3hDVz0q5IJ8GfSKXggFsRA=3D=3D?=
X-Microsoft-Antispam-Message-Info: oq33+SnDMZr1/M3Ld12YlSLz/VNzQ2At8vYJzC8k/8iqVCXOxCaDChaHd6erpjdQmNUeR03MZ9VG8GRo7AOXcl1vfj47cnTJ3PXp/0y0uP4AmzJ1RDd8Ty5fRi7/X7zkDSyP7ChekA3B6yTY9VR0EFy5pPQaNVE0flCHRJOaS1ADLHQmrFnon+/7Dy7lhwTlOc1Q6pcsjLcWPvdYYlvnbcDHpjhKZhsqt1kNA+BX//LcWPiBhOFo5YdkHnBeqeEqHpkijeZ4/fRrFf6xEgpT0YhrE4mm8yIshI9RV4tvWBTp/z/Ts4si51vyTz7OLFHQ+za6FrOBABGW69bSY/hIVMSw0zXANfw+igO6QYhvsKAttNlYVYHhjHXhMvRfsfnVzl0/lxEo575Q1awuzvvQsg==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB693;6:A/eXtzQpRIv60o4GlvWHdp50sYytC+ndyyXm8DXBgCKT8FGrSqKh3fwMY3MJ6ImD2hwaii4QArB3Cw3NCTpSPMTqJMXDCSOCIfE3l+7YLdunwWm9Om+MhB3OWixkX6Q24+pl1ua3Yym/wcjPStkeqqMzQox6v553MNzxcgwVErRAC6sdw0J3flIN76UJHJrCzYj2PpESL9qRGImhixiFKxM/6XmEr+9fy0LHuBsvc2b4kEyQQ5r/UPtiHPri4+Zcuym7RoZwqUU7R6e74xTAS8QRdQ6CpfVM15I+mI+3acnQZ3flzzIz7T/fta3EJAi3OB5s+fQeC+V4+kvGfRP9tiTaViMLzDrplInarlUQEbBRPLYWhwdnZ7+EAIYGG2VjOhK5tM0peYLeeZ9zeBMCyTL+ZrRlvH6sGQzi7tZaqI5Ube37yZKi6jCE0sF5Tca9fRNDtLAxqs5ZYx+AIeVH4Q==;5:eTTbmTjCi95butJJW77lPZ7AH+WjMM/SG8FLsnc00od20aqgYPkfhWD4N904K1+fDD4OQrq5VSha/0OPVJYkMFsSwJB7fT5RCC75+YSCPLIPdB4uQHGkhBdbqNvjgKu85RG/jISmVF7iZhD6PhZi1oG8di1WPcxQ+hP6ITVjOuY=;7:fgIWPwtnoAptwP5LTMu31nlCu4OAjJWvKjpJqsFpFeH3+68peYU2BblXboJwqMMwr3KbrADDyOZALXwtmJS+J2DMjnwAutnRWH5UO0t6gpEGNzwueZQrY47D6kRhKsz9qlpItnCv62d8w5n6vr/ElOZxmcgLNZ9m6NYRh4hZdLMyRIlW6kbHxNCszKLTmiEduPK96LUcHQeaS+mwhewhQytD2yg10wc9z3XIlOkdQ2nDCohcckI5pTlAkz4zT9Po
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB693;20:a74QWuQE6YbCfbK5QexZzAIv3qS9IJR8AT36cztSUi2ViROdIcZqHfcrx/I8veViK9bLJ3N8I+lYNqE28/o1XR46OkA8E/hf0ud9guq1idwdWiK1mRmaOVK2vfZ3HpEwxFc/8dNgMQLC87O5qDCO1+MnoKI8FVtQL2yWj7rgMUAEsYX4/91zN+Koo1HDdRjAdMrehB9gYpsMbwhFZAklHn2dEBV3AefH4s9sLvUibSYLr9zCj+gJcNyJ4ILtV3XR
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 16:16:40.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ca420-7f8a-471d-a974-08d62f94ed65
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB693
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=379 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The EP driver did not check the mask bit for each MSI before
sending it in raise_irq.  This is now checked, and -EINVAL is
returned if masked.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index c3a0889..b762214 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -332,6 +332,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	if (!interrupt_num || interrupt_num > msi_count)
 		return -EINVAL;
 
+	/* Check whether MSI is masked */
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_MASK_64);
+	if (data & (1 << (interrupt_num - 1)))
+		return -EINVAL;
+
 	/* Compute the data value to be written. */
 	data_mask = msi_count - 1;
 	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
-- 
1.9.0

