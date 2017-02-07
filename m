Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:29769 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbdBGWCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2017 17:02:52 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v17L4Lgv021428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-pci@vger.kernel.org>; Tue, 7 Feb 2017 21:04:22 GMT
Date: Wed, 8 Feb 2017 00:02:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jake Oshins <jakeo@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [bug report] PCI: hv: Add paravirtual PCI front-end for
 Microsoft Hyper-V VMs
Message-ID: <20170207210249.GN11103@mwanda>
References: <20170207071219.GA15335@mwanda>
 <SN1PR0301MB15983BEA28AFC3DE344E2A4AAB430@SN1PR0301MB1598.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SN1PR0301MB15983BEA28AFC3DE344E2A4AAB430@SN1PR0301MB1598.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 04:11:33PM +0000, Jake Oshins wrote:
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Monday, February 6, 2017 11:12 PM
> > To: Jake Oshins <jakeo@microsoft.com>
> > Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org
> > Subject: [bug report] PCI: hv: Add paravirtual PCI front-end for Microsoft
> > Hyper-V VMs
> > 
> > [ No idea why I haven never sent this email before.  I was just going
> >   through all the use after free warnings again today and noticed it. ]
> > 
> > Hello Jake Oshins,
> > 
> > The patch 4daace0d8ce8: "PCI: hv: Add paravirtual PCI front-end for
> > Microsoft Hyper-V VMs" from Feb 16, 2016, leads to the following
> > static checker warning:
> > 
> > 	drivers/pci/host/pci-hyperv.c:1441 pci_devices_present_work()
> > 	error: dereferencing freed memory 'dr'
> > 
> > drivers/pci/host/pci-hyperv.c
> >   1410          /* Pull this off the queue and process it if it was the last one. */
> >   1411          spin_lock_irqsave(&hbus->device_list_lock, flags);
> >   1412          while (!list_empty(&hbus->dr_list)) {
> >   1413                  dr = list_first_entry(&hbus->dr_list, struct hv_dr_state,
> >   1414                                        list_entry);
> >   1415                  list_del(&dr->list_entry);
> >   1416
> >   1417                  /* Throw this away if the list still has stuff in it. */
> >   1418                  if (!list_empty(&hbus->dr_list)) {
> >   1419                          kfree(dr);
> >                                 ^^^^^^^^^
> > We free "dr".  Presumably we should set dr = NULL here?
> > 
> >   1420                          continue;
> >   1421                  }
> >   1422          }
> >   1423          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >   1424
> >   1425          if (!dr) {
> >   1426                  up(&hbus->enum_sem);
> >   1427                  put_hvpcibus(hbus);
> >   1428                  return;
> >   1429          }
> >   1430
> >   1431          /* First, mark all existing children as reported missing. */
> >   1432          spin_lock_irqsave(&hbus->device_list_lock, flags);
> >   1433          list_for_each(iter, &hbus->children) {
> >   1434                          hpdev = container_of(iter, struct hv_pci_dev,
> >   1435                                               list_entry);
> >   1436                          hpdev->reported_missing = true;
> >   1437          }
> >   1438          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >   1439
> >   1440          /* Next, add back any reported devices. */
> >   1441          for (child_no = 0; child_no < dr->device_count; child_no++) {
> >                                               ^^^^^^^^^^^^^^^^
> > Use after free.
> > 
> >   1442                  found = false;
> >   1443                  new_desc = &dr->func[child_no];
> >   1444
> >   1445                  spin_lock_irqsave(&hbus->device_list_lock, flags);
> > 
> > 
> > regards,
> > dan carpenter
> 
> I'm pretty sure that this is a false positive.  It only frees the
> struct if there is another entry in the list, and then it immediately
> overwrites the pointer with the next entry in the list.
> 
> What's the right move here?  Should we send a patch that nulls the
> pointer just to make a static analysis hit go away?  It's not a hot
> path.

Nah...  Sorry.  I remember now that I did send this warning before and
K. Y. Srinivasan explained this to me like you did.

I'm close to being able to silence this false positive in Smatch.  Don't
worry about it.  My bad.

regards,
dan carpenter
