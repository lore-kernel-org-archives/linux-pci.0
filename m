Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFEC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 07:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CA520652
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 07:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FwDzxdYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CA520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeJAOC7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:02:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33556 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbeJAOC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 10:02:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id 84-v6so7508686qkf.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Oct 2018 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N48w49jBjL94B24cbVLLXIq5qlSHdDSCvhvnH3GcTKY=;
        b=FwDzxdYeRszpJqTJfqvBYokKKafr0+/EmTQ7HWlnnX1aJRRpkDKO9RHsuxamBocta0
         maVqDAbfo+3eGUZ+6lB50e8CAc7I7gcUrzoD7US/JRy69StLb8VmVoiRxG6Pa9clATSG
         LQOYNyTabZKvBf8a/OS3vfNSWSosSBmQ5QqR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N48w49jBjL94B24cbVLLXIq5qlSHdDSCvhvnH3GcTKY=;
        b=FrAt2zPnhQyuWe/Xtm/wtDeU1Cd1oZDvXd0HqChu9WSBH9lACzaCvUtXomiEYAOGh+
         nftl9/fTC1IQE55vqiz1Lr+rSrpetIRoEd2WOT2yO651f8RSm2vOw36ueoWpmnStC1gw
         c5vp2t3PPvtU2Dw/k764Jr09sq9Adua1WT0zabwBVxuBAsg6zQkQ9xj41BgeXb6Ljfni
         1ODNlaAi3jUIbr1X1nMsoS1KYID6WMK+invkEhUp/n8V4E5lVfMQ8lIe7ueqFh/yB/KA
         OmSptU7+WS66tNet0oKuKq0jE5PnnyjMqCSmOZqtBDkha5W4N5domkMeQdyXrGSowxDC
         ZrPA==
X-Gm-Message-State: ABuFfogxyJB+pAxfqOPRq970JVladcxpBDeZzFA49R4KLtIX54/cWNhr
        2mQjpjnHsqLPZOUGBAId5eWRw0aW5IXeWngvMEMzUQ==
X-Google-Smtp-Source: ACcGV623uOqnmDZq1kzm2RcgEe/ImOyAbXgeRbIQ4AfQnUzF5ziWKYu65hA90LNJnfUtCqYgTrTciCfJD5yGHA36sRo=
X-Received: by 2002:a37:a18c:: with SMTP id k134-v6mr1416641qke.203.1538378796700;
 Mon, 01 Oct 2018 00:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-4-git-send-email-suganath-prabu.subramani@broadcom.com> <20180926210918.GH28024@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180926210918.GH28024@bhelgaas-glaptop.roam.corp.google.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Mon, 1 Oct 2018 12:57:01 +0530
Message-ID: <CA+RiK66toWULgXRa+nZVOEom70ntQW8PTO7N_8qFn2AvXB_8QA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] mpt3sas: Introdude _scsih_get_shost_and_ioc.
To:     helgaas@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 2:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 26, 2018 at 09:52:36AM +0530, Suganath Prabu S wrote:
> > The code for getting shost and IOC is redundant so
> > moved that to function "scsih_get_shost_and_ioc".
> > Also checks for NULL are added to IOC and shost.
> >
> > Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 98 ++++++++++++++++++++++++++++=
++------
> >  1 file changed, 82 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sa=
s/mpt3sas_scsih.c
> > index 566a550..f6e92eb 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > @@ -9809,6 +9809,35 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
> >  }
> >
> >  /**
> > + * _scsih_get_shost_and_ioc - get shost and ioc
> > + *                   and verify whether they are NULL or not
> > + * @pdev: PCI device struct
> > + * @shost: address of scsi host pointer
> > + * @ioc: address of HBA adapter pointer
> > + *
> > + * Return zero if *shost and *ioc are not NULL otherwise return error =
number.
> > + */
> > +static int
> > +_scsih_get_shost_and_ioc(struct pci_dev *pdev,
> > +     struct Scsi_Host **shost, struct MPT3SAS_ADAPTER **ioc)
> > +{
> > +     *shost =3D pci_get_drvdata(pdev);
> > +     if (*shost =3D=3D NULL) {
> > +             dev_err(&pdev->dev, "pdev's driver data is null\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     *ioc =3D shost_priv(*shost);
> > +     if (*ioc =3D=3D NULL) {
> > +             dev_err(&pdev->dev, "shost's private data is null\n");
> > +             return -ENXIO;
>
> I think it's better to omit NULL pointer checks like these because
> there should not be a path where we can execute this code when these
> pointers are NULL.
>
> If there *is* such a path, I think that's a serious bug and it's
> better to oops when we try to dereference the NULL pointer.  If we
> just return an error code, it's likely the bug will be ignored and
> never fixed.
>
We have added the ioc and shost checks, because of kernel panic in
below scenario.
Have 3 HBA's in system and perform below operation.
1) Run =E2=80=9Cpoweroff=E2=80=9D.
2) Immediate hot unplug HBA.
We have observed, kernel's shutdown process has removed all the 3 HBA
devices smoothly,
and also user have unplugged the HBA device during this time. PCI
subsystem's hot-plug thread is also trying to remove
the hot plugged PCI device which is already removed/cleaned by the
shutdown process. (Which is not expected for the
already removed device) Due to this kernel panic is observed. And we
are not sure whether it
has to fixed from pciehp layer, so we added sanity checks in driver.

[ 1745.605510] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000a98
[ 1745.606554] IP: [<ffffffffa054c750>] scsih_remove+0x20/0x2d0 [mpt3sas]
[ 1745.607609] PGD 0
[ 1745.608621] Oops: 0000 [#1] SMP
[ 1745.622989] CPU: 0 PID: 668 Comm: kworker/0:2 Tainted: G
O    4.4.55-1.el7.elrepo.x86_64 #1
[ 1745.624800] Hardware name: PRO-MNU65930231
PRO-NME69559126/BRD-PRO55212588, BIOS 0.51e 05/08/2017
[ 1745.626673] Workqueue: pciehp-3 pciehp_power_thread
[ 1745.628566] task: ffff881fe50dd880 ti: ffff881fe88e4000 task.ti:
ffff881fe88e4000
[ 1745.630530] RIP: 0010:[<ffffffffa054c750>]  [<ffffffffa054c750>]
scsih_remove+0x20/0x2d0 [mpt3sas]
[ 1745.632577] RSP: 0018:ffff881fe88e7c98  EFLAGS: 00010292
[ 1745.634639] RAX: 0000000000000001 RBX: ffff881feef5c000 RCX: 00000000000=
00000
[ 1745.636718] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffff881feef=
5c000
[ 1745.638832] RBP: ffff881fe88e7cc8 R08: 0000000000000000 R09: 00000001802=
20002
[ 1745.640972] R10: 00000000eaf4a401 R11: ffffea007fabd280 R12: 00000000000=
00000
[ 1745.643136] R13: ffffffffa0576020 R14: ffff881fe9af8240 R15: 00000000000=
00000
[ 1745.645320] FS:  0000000000000000(0000) GS:ffff881ffde00000(0000)
knlGS:0000000000000000
[ 1745.647572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1745.649833] CR2: 0000000000000a98 CR3: 0000001fe76df000 CR4: 00000000003=
406f0
[ 1745.652147] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1745.654476] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1745.656825] Stack:
[ 1745.659138]  ffff881fe88e7cc8 ffff881feef5c098 ffff881feef5c000
ffffffffa0576020
[ 1745.661562]  ffff881fe9af8240 0000000000000000 ffff881fe88e7cf0
ffffffff8137f9d9
[ 1745.663990]  ffff881feef5c098 ffffffffa0576088 ffff881feef5c000
ffff881fe88e7d10
[ 1745.666428] Call Trace:
[ 1745.668830]  [<ffffffff8137f9d9>] pci_device_remove+0x39/0xc0
[ 1745.671256]  [<ffffffff8147db36>] __device_release_driver+0x96/0x130
[ 1745.673664]  [<ffffffff8147dbf3>] device_release_driver+0x23/0x30
[ 1745.676071]  [<ffffffff8137851c>] pci_stop_bus_device+0x8c/0xa0
[ 1745.678485]  [<ffffffff81378612>] pci_stop_and_remove_bus_device+0x12/0x=
20
[ 1745.680909]  [<ffffffff81392eea>] pciehp_unconfigure_device+0xaa/0x1b0
[ 1745.683331]  [<ffffffff813929e2>] pciehp_disable_slot+0x52/0xd0
[ 1745.685767]  [<ffffffff81392aed>] pciehp_power_thread+0x8d/0xb0
[ 1745.688210]  [<ffffffff8109728f>] process_one_work+0x14f/0x400
[ 1745.690633]  [<ffffffff81097b04>] worker_thread+0x114/0x470
[ 1745.693080]  [<ffffffff810979f0>] ? rescuer_thread+0x310/0x310
[ 1745.695518]  [<ffffffff8109d648>] kthread+0xd8/0xf0
[ 1745.697936]  [<ffffffff8109d570>] ? kthread_park+0x60/0x60
[ 1745.700359]  [<ffffffff816f854f>] ret_from_fork+0x3f/0x70
[ 1745.702747]  [<ffffffff8109d570>] ? kthread_park+0x60/0x60

> Bjorn
