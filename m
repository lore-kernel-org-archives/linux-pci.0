Return-Path: <SRS0=404H=AN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5AC433E0
	for <linux-pci@archiver.kernel.org>; Thu,  2 Jul 2020 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E101520772
	for <linux-pci@archiver.kernel.org>; Thu,  2 Jul 2020 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGBUTV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:19:21 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:47470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgGBUTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 16:19:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E89C7100E7B40;
        Thu,  2 Jul 2020 20:19:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast33_4f102f026e8c
X-Filterd-Recvd-Size: 3791
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Jul 2020 20:19:14 +0000 (UTC)
Message-ID: <66df632598aeafc48ecb15434e3d997438414e7f.camel@perches.com>
Subject: Re: PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 02 Jul 2020 13:19:12 -0700
In-Reply-To: <707b05c95ae3292a6b9eb04e146b1f1f6d52c125.camel@perches.com>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
         <20200630180917.GA3455699@bjorn-Precision-5520>
         <20200630140417.3a2dba67@lwn.net>
         <707b05c95ae3292a6b9eb04e146b1f1f6d52c125.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-06-30 at 22:35 -0700, Joe Perches wrote:
> On Tue, 2020-06-30 at 14:04 -0600, Jonathan Corbet wrote:
> > On Tue, 30 Jun 2020 13:09:17 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
> > > 
> > > The lkml.org, spinics.net, and gmane.org archives are not very reliable
> > > and, in some cases, not even easily accessible.  Replace links to them with
> > > links to lore.kernel.org, the archives hosted by kernel.org.
> > > 
> > > I found the gmane items via the Wayback Machine archive at
> > > https://web.archive.org/.
> > 
> > Heh...now *that* sounds like a project that could generate a lot of churn,
> > and perhaps even be worth it.  Settling on a consistent (and working!)
> > email archive would improve the docs quite a bit.  I'll add that to the
> > list...
> 
> At least for the lkml.org/lkml links
> here's the current -next diff done by a
> script that looks at the message-id of
> each lkml.org link.

btw: if you want to run the script for specific
paths, here's the script.

You could run it using:

bash convert_lkml_to_lore.sh <path>

---
$ cat convert_lkml_to_lore.sh
#!/bin/bash

cvt_lkml_to_lore ()
{
    tmpfile=$(mktemp ./.cvt_links.XXXXXXX)

    header=$(echo $1 | sed 's@/lkml/@/lkml/headers/@')

    wget -qO - $header > $tmpfile
    if [[ $? == 0 ]] ; then 
	link=$(grep -i '^Message-Id:' $tmpfile | head -1 | \
		   sed -r -e 's/^\s*Message-Id:\s*<\s*//' -e  's/\s*>\s*$//' -e 's@^@https://lore.kernel.org/r/@')
	#    echo "testlink: $link"
	if [ -n "$link" ] ; then
	    wget -qO - $link > /dev/null
	    if [[ $? == 0 ]] ; then
		echo $link
	    fi
	fi
    fi

    rm -f $tmpfile
}

git grep -P -o "\bhttps?://(?:www.)?lkml.org/lkml[\/\w]+" $@ |
    while read line ; do
	echo $line
	file=$(echo $line | cut -f1 -d':')
	link=$(echo $line | cut -f2- -d':')
	newlink=$(cvt_lkml_to_lore $link)
	if [[ -n "$newlink" ]] ; then
	    sed -i -e "s#\b$link\b#$newlink#" $file
	fi
    done


