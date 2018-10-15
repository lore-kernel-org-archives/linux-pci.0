Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C001C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 11:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F49E2083C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 11:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iDMFp9tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F49E2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeJOTRv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:17:51 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:30944
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbeJOTRv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 15:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0GLwDvZ2p9xWrkrTa1zqS8/8sO2of38GkyBw2wqUvI=;
 b=iDMFp9tGJMUqcDrq822R7QIIhmfso/IHhh0UeaeB1Z4UTg/5QxfVK1wW+bQVstie9/vlJlkLyWEa2rq6P05B55j+5a94THVVWMdiAxItLEUOh30U3zqwwdLO8+vfVFX04m4eMad0VrYWubPpfLqdFhBeTtWXJ4A14al0+Qft5vo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
Received: from [10.1.196.75] (217.140.106.50) by
 AM0PR08MB3090.eurprd08.prod.outlook.com (2603:10a6:208:5c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:32:52 +0000
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     mark.rutland@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, jasowang@redhat.com,
        linux-pci@vger.kernel.org, mst@redhat.com, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu, nd@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <33bd48e9-a061-e97d-ff00-daf5097b8e1f@arm.com>
Date:   Mon, 15 Oct 2018 12:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: LO2P265CA0347.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::23) To AM0PR08MB3090.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61133b0a-c456-4b17-6ef3-08d63291f20f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3090;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;3:XsZ1n61jf0dzLY7Hr+4mVJsm5IGiDNfpC1+KPmIHN2AOIziRciMIg75qaVyv28X/b3+mWuUPWMXknD4lFpeZg6nsb/md5V+EoLBvlvY2f7cTvsBeB19u8GguUFKd+baWie2Zh1bPoJXTAAnZXGWyhFE2OO9BWeGKj4AEOWwQI+hOwzRjEGcpd2vmGqK+CFMkQZmerBpgP8xIgnGfEsgwVbqrGGfcjxvCCGYWM6ib50zhJbl+92Vp5Of0I/g1C++T;25:VEKur8heQubHBGOs4pwbubyFb734Xv3Caqbcn4jBig3USM9EzcZEK39gc2Y1o5DEt9iMXLEr7xEdDKZ3vAy+b8ixc7qEH97IS2zjK8wdV32vL9MIVVHzIsrqlME2sPw8mydERlTn73tWwvGPzVv3NbEWjp18W3cvcPhobwVOAFnRmS4MoasmVMMlUcbgRy70XZIz/vqh2I/o74Ur5bf1QPskm9Saxrka9oib9wJ9R5SdTpnBhi7GkawAgFHWY5hFQav4pGsTP3z5xP6ed4sNWYVHIEq5kYQnkCx8kR/27cynx1Uves1prQwBL3YzbDquZ4gGKFYuQKTZWls1pEHfeA==;31:SWzgqkh+s0z+gwHvDs27If/NIMmrZrq+un3sxLK+teenRDecmewIDgkB/aVbnXlA8w6v55mHOfKG4ZhIGTQtBwP3WlfjtelaigTEppDmLzkFns2Csg2POcj9/OfXnqNKc4ZYOdaudcdxxY+DLAMBIiMWoQwaD+e6ub+crJmBGh1qY998+R85GH4FwQTnH9N7FGKgkvMEMu3TjApMSezBVkrjBiGKNdelXX4gEYe10Pk=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3090:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;20:+1zvtW/8ruUO9wQ1nIEwS5knc4rsIvST46C2vBPcekJOO+xRrY4kXdFG51A79NG0XHVA+KfxN7K1mUjpCYmKVJMDfvNNfuFmyTBTf58lfijMxBVc4QI0Ib1Xga6QyQhpkJqGL/+tV6qF1e2Hcb+pBjKbC+e4mekr/fuBHKnSXSQh+aCDD1J29y5bTflos8KNcLE3DYhHB1FXf3FqSAaMLkFgwKyoFnqXCJQWIUZR6oVDfTwdmekt6zdJR5nowBOaAz/NohrORSdR6wOt3q1paRpGBk0PtuoNQb89DGwntusZrPzjFaMA29oAOOSQJojpxllMYjb19Bo8rAxvzUAlDGRKc3A7mH7PXomGgSk9xnxPC6t5lgI0hWz7fs1Zh+qzUaMBGpIEpgM5hEf7qlu42qJqksDthxIeH8axe9vduzI=;4:Nm6AZzvxla9AcxjKspUVSv+5QSAS1MEjMDEU/JlIlcrS3adZHXHGhFPCpMmazYkcW/tVbdPQ3+jvrmsCkf94sxuwap93IYzWmB75iHSIpts1JQAE2K7tDnlJ/hmmpQJMSaVgkGHvFIXcwQcoaNA/BXMBozLi01Czf7C+bQOd0tf3oLaIKBfUsBivzEYUIsriZ5GHGGesa/aeUR02j3nT2N0PRjAMJrY2rKVWE/SZaY95n16HCHElzxqBvyvXatEWUiyt95M75y0MsxddEOy8N2XMAWZFgbJWj7scbnWcbff9JAUxEvn1PyhfyIcf5suwK+UGdJGzcjPVt7stOM1RHfB9DTKJ+GECVXdJ1RDMmkY=
X-Microsoft-Antispam-PRVS: <AM0PR08MB30901BA40CB7498AD92AF87E96FD0@AM0PR08MB3090.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:AM0PR08MB3090;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3090;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(97736004)(66066001)(65806001)(65956001)(68736007)(53936002)(6486002)(8936002)(36756003)(229853002)(31696002)(6246003)(81156014)(551934003)(86362001)(81166006)(25786009)(4326008)(316002)(47776003)(16576012)(305945005)(8676002)(7736002)(7416002)(65826007)(6116002)(50466002)(3846002)(230700001)(966005)(6636002)(2616005)(110136005)(58126008)(72206003)(478600001)(2906002)(64126003)(52116002)(52146003)(26005)(2486003)(23676004)(446003)(11346002)(476003)(486006)(44832011)(14444005)(6306002)(77096007)(67846002)(16526019)(186003)(5660300001)(76176011)(31686004)(386003)(53546011)(106356001)(105586002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3090;H:[10.1.196.75];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMDkwOzIzOlE5Qkc1V0xJM291eXgvOEl0WHBkSkFCSVNo?=
 =?utf-8?B?R0R0dmE2c1hISU1LNU9hTTRLK1UzWDZmMzFqMlluRllvQTdyZE9DNFpDeGVs?=
 =?utf-8?B?d3NDSnEyL3VsN0JnbmR3RnI5bldaRllvUGg3THlWYXJSU1d2RUIzWGZtZCt5?=
 =?utf-8?B?Y3hnS084TEZFWXFKc00vM2FTRTc4QjNRcnp3S1JNb2N1aEJ2czJ5TURtY3Nr?=
 =?utf-8?B?YUs4ZnExUUFobFFJYzZ2SnFNK1VCaUJtUFlJUXR3T0syUUxRR3FNSTVxcDMv?=
 =?utf-8?B?Zms2WUVKODl3ZjVIckRMODlEK0FIVmJUeGJhekMrTVhaU3hORVB1QXhxUkY4?=
 =?utf-8?B?M0JvV1Mzd21OZDMzc2tvMXVpWjFwRnBQbklMTWo0MHlvVGdjWmg0aVRpY2J1?=
 =?utf-8?B?Mk5wNENtQXUwL0VwNXU2a253S0ZGNHlHNUdiSkc0YzJDVFVCbm1ibC9yS3lv?=
 =?utf-8?B?L24vNlorSndEMUQxMVBrV1lrT2lXS3IrVlA0TFdvaG5UVStPOTJkdk56Uit6?=
 =?utf-8?B?dXJ3cDVSRnRQa29nMWhoNVJPOThIKzhpcytKa3RxL1FaZjQveXJJSGx5d2hi?=
 =?utf-8?B?bk0yUU1OeFhBUXlqZWVaeHlyWTNjTFpScUhaN0RxVVpFMjlZNzJ0VHpHdU8z?=
 =?utf-8?B?eUVKVDFXVTRja3FFZ05YSjNSTTNTdzVzK09CZklqdXNWZ0hjY2FjajB5bGtI?=
 =?utf-8?B?MTRjZUdWOVpzSEhTQWV2Snd5YkVZZHdrS3AweXVzUkJzM2FuUWhIdDAwMjI2?=
 =?utf-8?B?bTFYRVk5WVliOHNGaWpoeUJEOENPQ25wcTVQSzVBdUswTEhiTTNGUUdPMzFP?=
 =?utf-8?B?aFUvY2QxWEI5UkIrS2xvbXJPbFVIdVNXeXY1bkhWN1VXaFVNdHdLcmt3dG1X?=
 =?utf-8?B?aHF5aGhEZzZlLzhmTXFIUmNlekhiSWZXWGloZUg4dFN2dmo3cWhXbjJub0Ir?=
 =?utf-8?B?aHdDTVJzNWhLSktzRW5WTUhOOTVPNmViY0JleXVkc3VxYkF1NTVKWG9LaU5q?=
 =?utf-8?B?NzJrdDBnZUZ6ZWNZTVA1c0xaNHRPU01HVW4xQVBaQ0FlUHFJbUpWZFplcmNZ?=
 =?utf-8?B?VFhoeVZzcTRZSkM2MlhpeFJmL01KOXBzeVdTQkFDMGo2Yk42bW9ibmwzMFA0?=
 =?utf-8?B?YSs3S1MwK1ZFVXJhbUk0WDdJOGJzcDhRSnV6YVd1TDkyNE1kbmR3b1ZyT2JN?=
 =?utf-8?B?M1pNNjd3V1gxTUxid0ErYm1DMVVaWnpJM1NMMFNReVNZU3g0Q1oxVlhIYWE2?=
 =?utf-8?B?d09tYjkramdLaDZVS3Jjb25Sa05YZ2NGb3czUExvZjJ6d3VRR21zbkU5cXJR?=
 =?utf-8?B?YkREa0JwbER6UkhLSXk2SzJZUllvTGRTR1pDa0hKOHRCTEpUbFJoREMxSDdq?=
 =?utf-8?B?OTdGRFRKMWdkWnNSMmJYYlNtUWd0b0kyaXFSWHIvV0NPUzBIY214RXJDN1R4?=
 =?utf-8?B?SHI3NjgyM3N3VGdhb0N1Um9tTHlJWFo2cWZZM09QbTRocUtsektpeFlHV3RW?=
 =?utf-8?B?R1BLK0NDTGtlcTc3bU5qcjl4UG5rL3djRGhpcFRjSHFCZXQxdUptVjBnUmNO?=
 =?utf-8?B?dmZDWUNnT2VQNEZYMm5UMys1SlpGcVA0bkVyMnRNNG1zaERHdVZqQ05PNzNP?=
 =?utf-8?B?bmQxTDJoYVp0OUF5SFRibk91VUlNNjRWdDRsNWRIOEFXS1A5ckF2U0wyRkdv?=
 =?utf-8?B?SWd2TjNpVmNGb29HYXk3clhFUGhQVUxYd2VVaEo3bVFjdm4yNTkzc1lVdUE3?=
 =?utf-8?B?K3NMSDB4YUFWQVlHQitTcFIxVnhYRVJwT0hjWkVySFBwelRNVUtLdXZkNDNs?=
 =?utf-8?B?TEdPQ2VjdThtT3p6MkVqQjNFVUVBYkJvajBXSEJwY0VhREErZFVoSmxSZHpo?=
 =?utf-8?B?cUZIQmt1TXNzbGNpMUNZZUJ0Q0pEZWtZTXVwVW1TL012ZVFmZ1pzc3B5cXE0?=
 =?utf-8?B?eThmRXpiT3RiZVRvZWJFdFlHc280UTFNT1dXMG1nV1ZxSUVIMUZNOFZEazdX?=
 =?utf-8?B?S2lEZjdVTFMrVVVTK0kwNDBrQk0vdEhHaG5OV3hZMEQxa0hob3hzSUE4VFcy?=
 =?utf-8?B?ZjhsRHpLOEI3UnpsSTJkRjhuMW1XVmVQTWZ1Q1ZWUkREd1FSVUF4cjhCNmRx?=
 =?utf-8?Q?uLInX/AYsWR7eM4zJK/5B7Y=3D?=
X-Microsoft-Antispam-Message-Info: fX0+N39vPkkn6u04F0xoUn4bLtDsExYWnz2CfAhnSzVWK99lXGrwjnQwU3RlVzpXTEMKtFh/RmtDtXuZIKQBW/tKBwknSTrZcjhsbsCXD7s/7BIEASiDA+PMAE93XJOXgHcz4pyEcvRRJWTIIMLBHto/BQdv15EROI8cZzCAufuUpONmiIScdSvf40jY3GNOwZ5opWm7A/o5+iVpwSaryiJCDSKq7H42VqFsFh11acMfqGIWhuUzBH1rw+DUPHaSGKUwP5QfVFltuxyIRZGSx/yJ0bXm8++XhEXLIsDx40QFm366+7MCYxdInXAVpjdDLcw4T7BWXoHJ+KSajwPSsPZxuHSnZM0W/OP9PNdsIks=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;6:VdKt/RdihkZMIUdDHa3ciUitz5gLdAvbGdHkBAHRHhF0Ls9Ws4N4wbZy2ri8JxnG28E6MBIQrPDulIrJKcIM0JGtX14+lzEkMpAty8s2DyC7ifXgHX4ZN6Qqu/7MF6G1RoUHW3+mPBreuB3riNSG4jWpP3XlKaHTio15WIKQvy9iJHxkirZNflFHzwtfp+rJ7SCA0sYMFC+6sXFasofZsA0K7+AIFiNrGzYtp+OWWUs5tD9feyZBXM59VZPRDqdY6I5M2y3fdDsRO1npgmDyO91m5yoLfjkyiqXnVmiemW/he0i5SzlIKRXwcP9K5GyMUzw/BDh6COqZeelGUUkj1ep+FhM5qIHrwGCAUSlkZpwS316s9IG65mKqxJRGdAZ09UWYQgx5gGPdUIbHH7Gsxu9kog0mNHlhY3aKzLVR7ygw9Vw/RrmAyndsQdd7jkpELJiTgCDq/dyNFNMzRx0IjA==;5:K1bg8FYBKK5sVtzWfnEJ1BAdmJjJ6ZgJ7mUnuMPZMbfF6ZIYE7/boUmvbI4PX3kUiPfe0z+AO4LfX5ULYksylkL3zqELnexK+5GW8vidYLaXDSo8W6K/hI4LMb/Ob3nya3nwHHffAYPxlqrHwWWvAkWTfnIACkeH+FStYOYhFV4=;7:mmLh8/NdjfnjyOzJOxvJ25yOYPOhF3BQOjEr1fSuqEhguBa8Ab7tgGhoDACM3P1dRKZsjcZCFcB/ZlcaYKSTt3YmjEmU97VTva0o7B68UIQNJiwV+/sE8IqpLsfScF/05sPg1rInBiBpXfLvkjfMJT4FoZznp1HOiPhFrcd9zG5dGUVwOY8slUM5vgbcVfwOdcgTGOV6zP0X83HP/cCoUiaTHeWZU6nMM2zWoJIgfWt4mUZCTo8laN63ayI/0B4h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 11:32:52.9396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61133b0a-c456-4b17-6ef3-08d63291f20f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3090
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/18 20:41, Bjorn Helgaas wrote:
> s/iommu/IOMMU/ in subject
> 
> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
>> Using the iommu-map binding, endpoints in a given PCI domain can be
>> managed by different IOMMUs. Some virtual machines may allow a subset of
>> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
> 
> s/case/cases/
> 
>> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
>> PCI root complex has an iommu-map property, the driver requires all
>> endpoints to be described by the property. Allow the iommu-map property to
>> have gaps.
> 
> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
> iommu-map could inadvertently allow devices to bypass it?  Should we
> indicate something in dmesg (and/or sysfs) about devices that bypass
> it?

It's not really "allow devices to bypass the IOMMU" so much as "allow DT 
to describe devices which the IOMMU doesn't translate". It's a bit of an 
edge case for not-really-PCI devices, but FWIW I can certainly think of 
several ways to build real hardware like that. As for inadvertent errors 
leaving out IDs which *should* be in the map, that really depends on the 
IOMMU/driver implementation - e.g. SMMUv2 with arm-smmu.disable_bypass=0 
would treat the device as untranslated, whereas SMMUv3 would always 
generate a fault upon any transaction due to no valid stream table entry 
being programmed (not even a bypass one).

I reckon it's a sufficiently unusual case that keeping some sort of 
message probably is worthwhile (at pr_info rather than pr_err) in case 
someone does hit it by mistake.

>> Relaxing of_pci_map_rid also allows the msi-map property to have gaps,

At worst, I suppose we could always add yet another parameter for each 
caller to choose whether a missing entry is considered an error or not.

Robin.

> s/of_pci_map_rid/of_pci_map_rid()/
> 
>> which is invalid since MSIs always reach an MSI controller. Thankfully
>> Linux will error out later, when attempting to find an MSI domain for the
>> device.
> 
> Not clear to me what "error out" means here.  In a userspace program,
> I would infer that the program exits with an error message, but I
> doubt you mean that Linux exits.
> 
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>   drivers/pci/of.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 1836b8ddf292..2f5015bdb256 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
>>   		return 0;
>>   	}
>>   
>> -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
>> -		np, map_name, rid, target && *target ? *target : NULL);
>> -	return -EFAULT;
>> +	/* Bypasses translation */
>> +	if (id_out)
>> +		*id_out = rid;
>> +	return 0;
>>   }
>>   
>>   #if IS_ENABLED(CONFIG_OF_IRQ)
>> -- 
>> 2.19.1
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
