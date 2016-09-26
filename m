Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:10803 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161735AbcIZSJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 14:09:17 -0400
Subject: Re: [PATCH v5 08/16] IB/pvrdma: Add device command support
To: Yuval Shaia <yuval.shaia@oracle.com>
References: <cover.1474759181.git.aditr@vmware.com>
 <47e16986707ddbe0ffa15795ef9ae60d15bdd728.1474759181.git.aditr@vmware.com>
 <20160926071601.GA6352@yuval-lap.Home>
CC: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <jhansen@vmware.com>,
        <asarwade@vmware.com>, <georgezhang@vmware.com>,
        <bryantan@vmware.com>
From: Adit Ranadive <aditr@vmware.com>
Message-ID: <3697a394-4bb0-b745-1ae2-5e0583a53a96@vmware.com>
Date: Mon, 26 Sep 2016 11:06:06 -0700
MIME-Version: 1.0
In-Reply-To: <20160926071601.GA6352@yuval-lap.Home>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 26, 2016 at 00:16:01AM -0700, Yuval Shaia wrote:
> Minor question/suggestion inline.
> (sorry for missing it till now).
> 
> Yuval

<...>

> > +int
> > +pvrdma_cmd_post(struct pvrdma_dev *dev, union pvrdma_cmd_req *req,
> > +		union pvrdma_cmd_resp *resp, unsigned resp_code)
> > +{
> > +	int err;
> > +
> > +	dev_dbg(&dev->pdev->dev, "post request to device\n");
> > +
> > +	/* Serializiation */
> > +	down(&dev->cmd_sema);
> > +
> > +	BUILD_BUG_ON(sizeof(union pvrdma_cmd_req) !=
> > +		     sizeof(struct pvrdma_cmd_modify_qp));
> > +
> > +	spin_lock(&dev->cmd_lock);
> > +	memcpy(dev->cmd_slot, req, sizeof(*req));
> > +	spin_unlock(&dev->cmd_lock);
> > +
> > +	init_completion(&dev->cmd_done);
> > +	pvrdma_write_reg(dev, PVRDMA_REG_REQUEST, 0);
> > +
> > +	/* Make sure the request is written before reading status. */
> > +	mb();
> > +
> > +	err = pvrdma_read_reg(dev, PVRDMA_REG_ERR);
> > +	if (err == 0) {
> > +		if (resp != NULL)
> > +			err = pvrdma_cmd_recv(dev, resp, resp_code);
> > +	} else {
> > +		dev_warn(&dev->pdev->dev, "failed to write request %d\n", err);
> > +	}
> 
> Please note that callers checks if err<0  while here err!=0 considered as
> error.
> Looking at similar code in pvrdma_pci_probe i can see that function
> "translates" this error to -EINVAL. Suggesting to do the same here
> (although -EINVAL is not a good choice, if device can be more friendly with
> the return code then we can propagate it up or just print a suitable error
> i.e. EAGAIN or ENOMEM otherwise EFAULT should be sufficient).
>

Thanks for pointing this out.
I dont think we return a positive error from the error register. So the
(err == 0) should be (err >= 0). Also, I'll set the err to -EFAULT if
read_reg fails (based on your feedback on the other patch).
