Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BDC43610
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20B20864
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo3TMk+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF20B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeK2HSl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:18:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeK2HSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 02:18:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id n133so3879480wmd.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Nov 2018 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNuiRo70XymhuhLYCK5VWwkc3swbq+i6qQJWqN8IL1Q=;
        b=Uo3TMk+wOoSDfrIRDcfV2unDnVyd3JH1lolH8MALcmYOtFcBPJpK+dheBCXJsFXgOn
         ExAbBkrVr2kyN4a5/5UDCU38+BXr6HhE+iYnE7F/eZ79kAFfU4wVt0khcqXkPEg6ql00
         dISKA6pM6Kfq8hw2Frbj2mfhiT/GPy5aa2hIgZEm8KwT6/4eAJbjfVBi4RdsimoJUhFI
         SM2DUES2c9N6yIDFM3bieVFzt1sgll3EsmufdZkUIDFmLSfH6RTYhnATCdcADYcqc8kM
         XPaJq10TavzgWytpP3QhBQGfWFZECl5aQ+9VBIm7VD7cbH4acSc1T1Aq3OU9DVBSoU+q
         QbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNuiRo70XymhuhLYCK5VWwkc3swbq+i6qQJWqN8IL1Q=;
        b=iACpzkf/gig+31EEXd14KbRhKwAq6OgIB7ZzRP/NHmqq2vuQFsobTHXr8vRt4znrAh
         Eq04xYZ20JpSsmmbQQzqKBiheBsPw4MvlymztrJt8lXSZsRAXsMYRGzJ12AV17wJmlkG
         zV4IbXtklLiSwlnkLP+03jYZi6a8jfIlK8XktB0YlVLusgBOmxog2QvHzNonkKNfS6OL
         hHQssMvRwIChPnVUFDlU+RBm5zjJjavDCEIyROv+15g2D9Zx1VpnfqxSzRcPm+mPaYA8
         poQVMH2qlFlVoHVQdo+p/24U1mnvxb64CiuxHHvgdLh6YKrKmb9GPsGnw/E+Ox4P8NBz
         ZSgQ==
X-Gm-Message-State: AA+aEWZln11m5fC54Qhxuq2j882ldmfP38ssYM1jv0hTTVdPeeniROXt
        yiGVjlAvwXK+wPVepE0JkW4IK1i1aOdAu17Qvb9+
X-Google-Smtp-Source: AFSGD/Xu3hYRB843DPXXo6eLq4VKs6teqeylkfQy68RaxSxmHi3DJVGRWJGx8O6G2IC173ODFo/bUX+tz/VN4/jTX4A=
X-Received: by 2002:a1c:9b84:: with SMTP id d126mr3862737wme.62.1543436148085;
 Wed, 28 Nov 2018 12:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
 <20181127153356.GA112381@google.com> <20181127090830.084fedf1@x1.home> <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 28 Nov 2018 14:15:36 -0600
Message-ID: <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
To:     bharat.bhushan@nxp.com
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bharatb.yadav@gmail.com, David Daney <david.daney@cavium.com>,
        jglauber@cavium.com, mbroemme@libmpq.org, chrisrblake93@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 10:32 PM Bharat Bhushan <bharat.bhushan@nxp.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, November 27, 2018 9:39 PM
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Bharat Bhushan <bharat.bhushan@nxp.com>; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; bharatb.yadav@gmail.com; David Daney
> > <david.daney@cavium.com>; Jan Glauber <jglauber@cavium.com>; Maik
> > Broemme <mbroemme@libmpq.org>; Chris Blake
> > <chrisrblake93@gmail.com>
> > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> >
> > On Tue, 27 Nov 2018 09:33:56 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > 4) Is there a hardware erratum for this?  If so, please include the
> > > URL here.
>
> No h/w errata as of now.

Does that mean (a) the HW folks agree this is a hardware problem but
they haven't written an erratum, (b) there is an erratum but it isn't
public, (c) we don't have any concrete evidence of a hardware problem,
but things just don't work if we do a bus reset, (d) something else?

> In pci_reset_secondary_bus() I have tried to increase the delay after reset but not helped.
> Do I need to add delay at some other place as well?

No, I think the place you tried should be enough.

You should also be able to exercise this from user-space by using
"setpci" to set and clear the Secondary Bus Reset bit in the Bridge
Control register.  Then you can also use setpci to read/write config
space of the NIC.  The kernel would normally read the Vendor and
Device IDs as the first access to the device during enumeration.  You
also might be able to learn something by using "lspci -vv" on the
bridge before and after the reset to see if it logs any AER bits (if
it supports AER) or the other standard error logging bits.
