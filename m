Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3C9ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EA221526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DHhkb6x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EA221526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJQWR5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:17:57 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:26912
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbeJQWR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 18:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyLikbyNt9nqptay8fNa5Wi197JVCg2TNYUQvw4QGu4=;
 b=DHhkb6x2juKpaSq0K7MKEit5hzwu6ZN+PscGAsQbl1YhZZ6F83Z5WK3vtwsJTiMzLx20mh/M+4M469ZqxlGgsGKL0Un3c4MfHILUnTFokn8O44TklAE+3BromJlyeZtanmMYEsa5ov3UaYAuOyAOAo6TD7ODXlr59PTQCLexpoE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jean-Philippe.Brucker@arm.com; 
Received: from [10.1.196.78] (217.140.106.50) by
 AM6PR08MB3046.eurprd08.prod.outlook.com (2603:10a6:209:45::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 17 Oct 2018 14:21:56 +0000
Subject: Re: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
To:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-11-jean-philippe.brucker@arm.com>
 <20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3e1b58bb-eb16-5855-2922-2b15b37ba971@arm.com>
Date:   Wed, 17 Oct 2018 15:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: CWLP265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::30) To AM6PR08MB3046.eurprd08.prod.outlook.com
 (2603:10a6:209:45::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbf26b4-a96e-4556-8885-08d6343be4e0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3046;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3046;3:+WIzm1PWy7U8xqpeq8f6xKZzVz779eXqiql0FksedAAGmDw4DX+5Ms2WrbiQDhcSVjjJ2vR0zMQhV5TtT5BO4eGDEsK6UgsXE9X6/Tc7xRjLLzWSPPeGfPZUE04JetT9wAqGnsOdTm7ENirSLxCK3KYf0ymyailQpsEVglZF9AUpFRPGiOHl+JKrAMIx8MuMma+Shi4CEU/nlie9m/cvl2fGS7784meaC8YumWbhw8f6sDaZ8mmFUbtW80b/ambq;25:RxxdKsHRZ+RryLhXsRz7BWeQrQUuODpgfFDTDqkQdEJL26nfQr81Klu+wIM03dmKRTvSA0DE3nHRYLTyXW8A0WPZiW8ExgMZLEA+xRNX9MJdUWUmTf8+7qwhwVmvk73cVXGC6gp1DDz1hdsTBrIdfvlZbx3ZQOzK5zgWB79fzTLE1YQzjXP9GcR5EV65PLhUVyPWCEZw+sUAcd8Kj/wot6oZsl1VC5hPvs/LXf5bviQPX+PblXryYK21o68Fm1rUkgvG/r8tmXcraiJ9IQ8jMsSJuqs4ExVqAtiv7+f9sFY+DlWbu6dgBp0qA9xHAzcCpgcDR95RFGi1OuVuQCGQkA==;31:SQDmrW7xBR1TWmlISPkiiBB/payvKZaBKZ7BvMmOIs6OxREqamtKajwfGnPYtnd62O66LIigBVhaOSMAfrQnV52v5/9YXrUqkncEAts7YM5jKodC6E8eJ3uqfb/iRHL4nkMxik5Fafn6F0xjdxkBhzJzF0XrRlPrZXIK6XKaX8f/OiFurHE4lywk0+iZn8+p0nSe9et+Q3I39Egqyz6vHPjMY5uJSM4lyLIZqgCKuL4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3046:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3046;20:nhzooUx/lNrhsBENeBomKfOSgpla0pSmDnKFNnd09fltkk4q5LYlTNjssqW9bQiGVdkwQ7zcwwnoHlmYBuKpfR36i2OE2L7c0LvLnP0RDLu7cUhD2BAP/6f2ewYzIUQcfRetSvx5OaJwmFSq1CjtwY5NyKkIJbfJ5iuxaDdF/lywogWtbnpgu/GodVnFdGl9KW26HnjAhhgEqxI87xfeDv7jpG0WITt1E2InMWq5m86u60VwzOuJDc30aRnZcsqccmBldYkQUWUcoS62tPldo0LtRewkpbv3E2S4vWOFwk4lTgQiiWvfexvSPpLBuEM/PmN8i+k5YT316oj6RO7gkALLHxPTZZP7eu/nwzd9/jHxLx1Qed0bx/UL6xv3BiK4wkwMokx9M0hzO9IkHqdBdCMDunbV+1BDfnHVRJ8w0+iIpRz9LJzyr/BgxsSsEVGUFzIfYC6jRoGt3b6EMogpXQO5V2wK7E6D6fTWjcbV/oVjCisPHEvvXqRENxBOc1+b;4:E/qeiM5sroxNKzsq0tnsY8QAHtqqiS6N9wh9BPU/PL5hyRpaVcKYevKrdCl6dORpAZEx/Nc05JnacQeUo+h+yKlPKb9zl8TVqk3hClgJ0kRfh1aNIxOV68D/U/NdpuaGqjycpgLVFGmmtyAs/3HTq4XMpknrDuG+FEYnQPZcD+ucTbw+O1iBTJD7skJIiJO9AK7lglDU70gr6Hr8yzG/LFjeml8MGrSdUh94B/M84TqkzvmusDga0JEG3el3j0nTLRBHeF3hZnk+ECSMzcSiFauMWG2x9/M8D0cws/0E2WzegCNa9rI+lrNRXsDHgQIvfOLOb58ssXz14iSS+4nPjstjH/akQjIkM3GEAWXmRP2AZcEBwK1TsyLzuJr5A2g/
X-Microsoft-Antispam-PRVS: <AM6PR08MB30465800625612FE21D88304A3FF0@AM6PR08MB3046.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(788757137089)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3046;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3046;
X-Forefront-PRVS: 08286A0BE2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(346002)(376002)(39860400002)(366004)(396003)(40434004)(189003)(199004)(305945005)(31696002)(476003)(53546011)(486006)(386003)(6306002)(86362001)(6116002)(2906002)(478600001)(3846002)(65826007)(8676002)(8936002)(5660300001)(53936002)(16576012)(52116002)(8746002)(81166006)(58126008)(7736002)(81156014)(2616005)(23676004)(11346002)(956004)(446003)(6246003)(76176011)(52146003)(6666004)(2486003)(64126003)(50466002)(72206003)(47776003)(36756003)(66066001)(26005)(65956001)(65806001)(25786009)(106356001)(77096007)(5024004)(14444005)(186003)(97736004)(16526019)(316002)(105586002)(31686004)(68736007)(6486002)(229853002)(7416002)(217873002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3046;H:[10.1.196.78];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMDQ2OzIzOld1KzVIbWdvcTR1WGJxazcranYrUFdhUWxM?=
 =?utf-8?B?bFg2QTcyd3JoZjI0TEZuTXFTUUZxMDJJK1BEc004U3RMMUkrZk5UQ3lreVBV?=
 =?utf-8?B?dFJta2dsVmRzT2Z5bGQweGV4UHhRTTRDdDVsM1lURTNVdjhseDV6SERWNEZY?=
 =?utf-8?B?TFZ3Q3c2YXNCbnppc2YzRlVmcWludUhSMjl5d0kvcy9EdzBJdFpxUzZpNnZU?=
 =?utf-8?B?bXZobDdsekR5OW5ONHBVS0xXTUVNai9rMG5rL2MrSFhJcVgrNTQxT2UveHZx?=
 =?utf-8?B?OVU3cysxQWYyZUZyVHMwVlZnM0dMUjRJczE2NGx4YmxCUHY4NzZ5WFE0cFk2?=
 =?utf-8?B?NUVEc0N5OHcxOWU0am1WcXF5cUdXOU13V1FRdmZKUjZIWGJaZmRRZ3p6b1BG?=
 =?utf-8?B?Zzh4aWU5SWFoakM0Vmk3MEV1a2xjWHZtNDNEMXBPL1VXbFBta2RyR1RNVitM?=
 =?utf-8?B?MWpGWEpXeExUdS9aSjZ5T0N4MnJIa0tCdHJBbXcreDZmYjJDckpIOFQwVVha?=
 =?utf-8?B?QUVXWkVDdm1CVmVZc0VvbEcya1JoTjhnU0FkNlFQREp1bHVFMStWWTU4MXlj?=
 =?utf-8?B?WTVkNStDTGdhdmJwdVQ0c1dML1pZMTBUcHdCYlM1QlFZNVpCUVFsd0pTd1FV?=
 =?utf-8?B?V2R3eFNLZ1Jjd1JmUldvajk3REswVTZ4elREc1B4NU9DOHhYRXF3RDFsbFF3?=
 =?utf-8?B?bzgxKy80OGNYMjNNQjlwUCtxelpLSGh4TzJMTC9EN1dlckE1ZTk0dHc5b2dW?=
 =?utf-8?B?Rnh0dnhjSm9POTlSYlRpZHdVSTBVSDUwR3ZzVExEM2l6MDQrZnB0dEhwYzBr?=
 =?utf-8?B?U3o3NkNpc1NURWFlMDJ6dm1jNDFlNUxGZGtacEhkcXY3ZzVoT0JMUmxjSm9F?=
 =?utf-8?B?b25XQ3BaZnpmMGErYTVNUTE1TEdsV3IzTTF6aWdBN01XbTg2bUNJa0ZuSEtl?=
 =?utf-8?B?eGd4c3FPR3pPeS9mOGUvOHp1dmV4NUl1eXF2NEsxejlXallMbmxmVzRhMFFG?=
 =?utf-8?B?WnR2a2ptcXdvZk92dnJ1Q3lBZ3Q5cEROZkZXb2k4YkpxVVBYUWlVckxDUW9o?=
 =?utf-8?B?c3hKMG5ZQThtV0pjM2VoS0MzdzVqa3J1c3phV2owQXBkNUk0ajIydmd1bXNZ?=
 =?utf-8?B?bnQ4MmJyQ3pRdm1uWDFnWmdUOWU0Z1gyZzNqWUhqWThFS3dqUHBvVDZ2Yk1C?=
 =?utf-8?B?WVJ6QzZJdDU2VHJyV1NNZkRGWVA4Zm9PYzRXUDFJalY4SDlkZkJ5VjlLWmJ3?=
 =?utf-8?B?KzlPVVkzMXVFVVk3NURsY0dnWTU2bE1NMENFcGcvL2pvMkZub1FrVk1jdHJY?=
 =?utf-8?B?WXAwSzJsbG0yMjRoY0dTbTE0eEl4RDhqY1ZhMGVlemhiVlFYOTRPdUZXYzVl?=
 =?utf-8?B?elpMUWVNSnFsUURzaXlzbkpMZWpaWHNlZmRWemFrV0N4MWwwK3FuTTRySEtC?=
 =?utf-8?B?aGl3UWRlVGtQeGptM2NLOC9ycTJZQWZhRFZ4bGlWYWVSTTBlSkdobm1MM0Vu?=
 =?utf-8?B?RjNaZVlJdWsrZ0dJZlhRbnlrZnVIQkNEbWRCc0JjUU11OU4yK0paaTE3YXhL?=
 =?utf-8?B?dm5hMXJ0QzBqaWYrTlUrQmVDS1FEV21ycU9rQ1J3MllSeHJ3NFNxdmszMUV5?=
 =?utf-8?B?dUxYc0IxSXhiYXUvaFNLMWNza2kvaWgyVzNVeE1IRkI4aXRkUUlKVVdMNGVP?=
 =?utf-8?B?bU5sM0N6V1dNL2g2cGlSYys0U1lqZXJMTklJYlhjYUV3NDRHWXJ3eDI3dSth?=
 =?utf-8?B?dGRsTDdxeDVTSzZLNDBLSkpMM2JtYUU1anpUaUl1MUd2UEYraCtNZ3BqdklU?=
 =?utf-8?B?bWxYZ2FDeTBvQkxLUUVoaUVhY216NUFqYmtaT1ArekpvbkM2dm5KbUpDZzZq?=
 =?utf-8?B?ZjdMeVFVc3paMTdNVTNPNWt1VlYva0t3OHNmK3hLM2QvdWZaWHh4L2NaMkg3?=
 =?utf-8?B?SGo3WmR2QUdwUzhxR0NGYTdvdVhOTzVyVHlrYXFWM1BGVlF2elpBdkN1aHI3?=
 =?utf-8?B?aC9zZjB2N0VpQS9adW04cGtvS0VyUlhJK2FGemhxbTRUcGZ2a0RqNjVtN093?=
 =?utf-8?Q?Wz/Wm2NZXtd+SqiWNKgW07CLX?=
X-Microsoft-Antispam-Message-Info: qdN6wsQCTASBe1M4RGEdVl+7wqdjxG0mnmQPzxiub9P6/zPgWEzlhqz4Zyf2quuZc8LgJ2ywypMSI+SAzS9cf6jBdhWDxhAb6qZKU7mhiLI/wyUboEUdRFh98r6JC4kuUZbKhSPhNnZfxjFtupWFQwaLg1lFFkuR54iSDzZmlCkFCgGq38b+FxTu9JhJ4LNGmObmZ11ZjQ0iejcjqfejD/rdnf/bIw5Yk8IfoZ52mqiLmIqtCXVujbXGPJUbnd2gw8lMFaoxgaw+LQ70x86sHxPfQTBBKB3Ye/VLo95JOaHYTZfq3ecta62zg5gCUI3rNvjjmiq+o0q2ZrcDRE8nu4VMEQbwWkkT7RWKdFkgjd8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3046;6:hEL8kOAHFIaPl9GcaOOYtfKb7mutSijQeQGJEupWVYeQoRj4VMwzyb2q2McOclU0+f6jDyFPShRH2nGoj1AQImV/Wa+a4F9PqJrhiw1ww52doLxXz1vwPRRRcV7smWIM4cMSBcMQAf6JoJcgOfrTiK6ImwLCdxc/vUeE+SbO3jYYHqc6KU4+Ql5KVF0EmTwPsOlHu5U/XqUueOMfRoDLBcbdQBjJacj6bsnOnRKKXzJ4EuLgc6Kcv/Go+fzBjyGPTrFBS7ZJ+Ec54Rti/ZlHSDniHmW12BaB/+911oyJPOpWHXK0iGo/wFDhNdDXQk8gz5j9YCRtBZvFd3TvfWo3SoZUaXPTGp3+yPuzEzAdM0qwL1CRTeDUuqMhqtePjXvrcs7WUwAamWwmJVaUwqYNvQbuM2i4MgFaE0w/EssA6r7AkDWjbw1H8jD4GGxH72IVcWxlgtcQPCVXWxTZYqGWQQ==;5:8X9GvZFgpA30Xuc7Ar2BURxOvYH5wLkpjdtCeZJY31YclxPolzxG05TETLCAtb5To88lDRqMljo6xZNaWr2qWaTGO2Nx0Fz+sIOXbPILxjLoswRrFB7iFuLs2WqO8CEVKnH8Bzhsd5QNp80e2fZr29nm8oOaBZ7YC0IxWT7ig64=;7:JokRtERsWULy48llSysznyXDrK4s/eiTFmNd9HzvKve0EEq4B3TZZUQnZHKiWx+k9KkC7eakAUyCAW+ys2w1VD5P3e/SQ9Z8Bh/e1RRdaVomUokTIRNZR0Eaww2NCqHu5ibLuBpFErt+A8w89z01UvUDxz2RuKvBP/kSltMZImYdMVVWsk7g6DiHXAax6Kq6FkohI0QGf58qj26+e9LLlMkfIYbgACfSV8vf+4nrsgCtCP3QGLVtC3jJScdbqLEU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 14:21:56.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf26b4-a96e-4556-8885-08d6343be4e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3046
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jordan,

On 12/10/2018 15:32, Jordan Crouse wrote:
> On Thu, Sep 20, 2018 at 06:00:46PM +0100, Jean-Philippe Brucker wrote:
>> Provide an API for allocating PASIDs and populating them manually. To ea=
se
>> cleanup and factor allocation code, reuse the io_mm structure for privat=
e
>> PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound t=
o
>> multiple devices. The mm_alloc() IOMMU op must now check if the mm
>> argument is NULL, in which case it should allocate io_pgtables instead o=
f
>> binding to an mm.
>>
>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>> Sadly this probably won't be the final thing. The API in this patch is
>> used like this:
>>
>>         iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
>>         iommu_sva_map(io_mm, ...)
>>         iommu_sva_unmap(io_mm, ...)
>>         iommu_sva_free_pasid(dev, io_mm)
>>
>> The proposed API for auxiliary domains is in an early stage but might
>> replace this patch and could be used like this:
>>
>>         iommu_enable_aux_domain(dev)
>>         d =3D iommu_domain_alloc()
>>         iommu_attach_aux(dev, d)
>>         iommu_aux_id(d) -> PASID
>>         iommu_map(d, ...)
>>         iommu_unmap(d, ...)
>>         iommu_detach_aux(dev, d)
>>         iommu_domain_free(d)
>>
>> The advantage being that the driver doesn't have to use a special
>> version of map/unmap/etc.
>
> Hi Jean-Phillippe -
>
> Have you thought about this any more? I want to send out a
> refresh for the per-context pagetables for arm-smmu so if we want to chan=
ge
> the underlying assumptions this would be a great time.
>
> For my part I'm okay with either model. In fact the second one is closer
> to the original implementation that I sent out so I have a clear developm=
ent
> path in mind for either option depending on what the community decides.

We'll probably go with the second model. I'm trying to make the latest
version work with SMMUv3
(https://lwn.net/ml/linux-kernel/20181012051632.26064-1-baolu.lu@linux.inte=
l.com/)
and I'd like to send an RFC soon

Thanks,
Jean
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
