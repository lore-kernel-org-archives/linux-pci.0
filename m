Return-Path: <SRS0=OdYA=3L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D1AC33CAF
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB02467B
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbgAVJsY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:48:24 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58538 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgAVJsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 04:48:19 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id B40B41C1CBB
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:48:17 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 4B19B1A0561; Wed, 22 Jan 2020 10:48:17 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:48:17 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, jcm@redhat.com,
        nariman.poushin@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH 1/2] lspci: CCIX DVSEC initial support
Message-ID: <mj+md-20200122.094223.48382.albireo@ucw.cz>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
 <20190627144355.27913-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627144355.27913-2-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.26), country: CZ(-0.00), ip: 91.219.245.20(-0.37)];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         DMARC_NA(0.00)[ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.924];
         R_SPF_NA(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-220120,linux-pci=vger.kernel.org];
         MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: B40B41C1CBB
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

A couple of remarks to the code:

> +#define ARRAY_SIZE(x) sizeof(x)/sizeof(*(x))

This can be useful in other parts, too, so please move it to pciutils.h.

> +struct ccix_state {
> +  int portagg_capable:1;
> +  int sw_portal_capable:1;
> +  int forwarding:1;

Please avoid bit fields. There is no need to save data size at the expense
of increasing code size.

> +static const char * ccix_sub_mem_types[8] = {

This should be "static const char * const ccix_sub_mem_types[8]".

> +  printf("\t\t\t\t\tMemErr:\t");

Could you please try decreasing the overall amount of indent to make
the output narrower?

> +    switch (value) {
> +    case 0 ... 2:

Please avoid GCC extensions.

> +static void
> +cap_dvsec(struct device *d, int where)
> +{
> +  u32 buff;
> +
> +  printf("Designated Vendor-Specific <>\n");
> +
> +  if (verbose < 2)
> +    return;

The "<>" does not make much sense now :)

If verbose < 2, I would print

	Designated Vendor-Specific: vendor XXXX, version NNN

> +    buff = get_conf_long(d, where + 4);
> +    printf("\t\tVendor:%4x Version:%u\n", buff & 0xFFFF, (buff >> 16) & 0xF);
> +    switch (buff & 0xffff) {

Maybe read two 16-bit numbers instead?

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"Snow falling on Perl. White noise covering line noise. Hides all the bugs too." -- J. Putnam
