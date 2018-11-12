Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F767C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47C021527
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 05:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJzXJp5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47C021527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbeKLPlr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:41:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43453 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeKLPlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 10:41:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so3529250pgv.10;
        Sun, 11 Nov 2018 21:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrmL7Du1NbWY/5sS9o08zjGgUgjgtOcnb7Ykw9rbzKE=;
        b=uJzXJp5DBuVrqA9qOfPwdBfl0pOcSJ9gmbVLppKY9ayC5xdujydFpNFFd0axJVVneG
         ueNWDRTuEUCV+5S/mdsKmha3gDfZfn2EqUI7RIcNnyxvmAw5LxuZQfFFhXU4QBmS1dpX
         HhWn+m0KNmYsZq///TgNBxL+VKkZoxuDYha3pFbw8shMTh5HIF4eK7Pwc2HmgdPeYGCi
         dlysU86T6p7V3L6kwi11wIhRiPg2fQI2J9txgKrcgw1JR1Mh/0LPpiPsv4P/SRtiGkBf
         cpx9UiSrEDeKfOsd4yaTuH+iSID0CETMbo1xbBRicY1pAFXYM6ifWphPIZPLfKlhO6X0
         Jhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RrmL7Du1NbWY/5sS9o08zjGgUgjgtOcnb7Ykw9rbzKE=;
        b=Me0ew0w30lvH2kmLipNFBWgQMu2BZwVF1WGuQ/YmTQlS3VTFmczIuYhHahLO9wbY8P
         lZnPhiAmafJgb4TuirMw2VgR5WbG1dQbgtX7aodwex+pbZtLJFBu+uaxi5IuTIsuwXXA
         ddtABdfF8dXxT7sUScdAr/mqyhSlGDf6w5wyCPdP5c7ilxgstLmd6WdRUkZIXU0ghbjd
         Vk8g+We/X+eio2eerS3wjI7U0SebldFbrxCJRTKvQwPHsWi3cTamBeUsxI4QS6ahIzoM
         TXRBJNk0BZ7oc2tpEQ4PxXK/7/rS9cQDF2n6ei1druw8/fNj1B9Ahm2Wr73Lk3DUyQ3j
         7UVA==
X-Gm-Message-State: AGRZ1gL6BRL++rRNcJBGo/uO80GQ2Bm1asxS+xJ31JG2GSGIM/wcKsak
        kzG5d+DjyZaZSBaBABDs9k8=
X-Google-Smtp-Source: AJdET5f1tcOT6q/FlP65O7ElMKcTuljCQhQuCxoFHc7UFMZMe1+BxgLkCcOUz0I+MQTnxIDCJ5UTNQ==
X-Received: by 2002:a63:9402:: with SMTP id m2mr15656255pge.93.1542001806794;
        Sun, 11 Nov 2018 21:50:06 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id d202sm758911pfd.58.2018.11.11.21.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:50:06 -0800 (PST)
Message-ID: <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Alex_Gagniuc@Dellteam.com, gregkh@linuxfoundation.org
Cc:     keith.busch@intel.com, helgaas@kernel.org, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, linux-kernel@vger.kernel.org,
        jonathan.derrick@intel.com, lukas@wunner.de, ruscur@russell.cc,
        sbobroff@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Nov 2018 16:49:59 +1100
In-Reply-To: <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
         <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
         <20181108220117.GA11466@kroah.com>
         <20181108223258.GD2932@localhost.localdomain>
         <20181108224255.GA20619@kroah.com>
         <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
         <20181108225109.GA3023@kroah.com>
         <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-11-08 at 23:06 +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/08/2018 04:51 PM, Greg KH wrote:
> > On Thu, Nov 08, 2018 at 10:49:08PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > > In the case that we're trying to fix, this code executing is a result of
> > > the device being gone, so we can guarantee race-free operation. I agree
> > > that there is a race, in the general case. As far as checking the result
> > > for all F's, that's not an option when firmware crashes the system as a
> > > result of the mmio read/write. It's never pretty when firmware gets
> > > involved.
> > 
> > If you have firmware that crashes the system when you try to read from a
> > PCI device that was hot-removed, that is broken firmware and needs to be
> > fixed.  The kernel can not work around that as again, you will never win
> > that race.
> 
> But it's not the firmware that crashes. It's linux as a result of a 
> fatal error message from the firmware. And we can't fix that because FFS 
> handling requires that the system reboots [1].

Do we know the exact circumsances that result in firmware requesting a
reboot? If it happen on any PCIe error I don't see what we can do to
prevent that beyond masking UEs entirely (are we even allowed to do
that on FFS systems?).

> If we're going to say that we don't want to support FFS because it's a 
> separate code path, and different flow, that's fine. I am myself, not a 
> fan of FFS. But if we're going to continue supporting it, I think we'll 
> continue to have to resolve these sort of unintended consequences.
> 
> Alex
> 
> [1] ACPI 6.2, 18.1 - Hardware Errors and Error Sources

