Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A47326945
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405700; cv=none; b=Rk8BwO5KL8vWilskQswr1WcvHV+CRcBtm5pjOO4yJAdIM5WfTz4/w+GatLyvhgnEvsRXheLMoDNiMXW9hTXc2uYrEK0eyVhZfxS3S5RwuCVihR3DeCN4SmW8/lsYs3fSnA3HNp9tc5zjtqUizwjHAqqez+Oi2Zv7ya4vnAVjQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405700; c=relaxed/simple;
	bh=Hkw5eP0AH3B+at6i6DNtRs8qAvsqQ9FMzhTvJAREaBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s72U2sM8Z1VWnblZLkgkNj+jHqR6fggl79CRF/iKgjSknqF7NXgOgZSfO6rgjzQ+nP3DRZ1d+RoGaKWRPPVoN+fGS3Lrx2XaunGVOvSAO1JG/LTKRiGPdaNpB0+/yoDWd4dY1LPbq/zOTvOle3DIUdXFq9kDf/s2e8reu3JPytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaJ0Yqht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaJ0Yqht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74C31F000E9;
	Thu, 30 Jul 2026 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405699;
	bh=DVVpIFks9TNzev8I3EkTUPqgPSV18ZWjwNQhuJLMwyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TaJ0YqhtqNChVEKc/vQjkrwNrDEG9EmMO5SEs5881xhyaEOlt1fDi9bP3l42EjfK6
	 zzwWDL1LzhjuZWbBd0yN0SylbhBqoxtIZtVQQzHfDoJcj9UEvVH2zI7sAvqFCwxP9R
	 jvhtktbQdz4R8GrMxQX6Zl51+l+dZs4j3ESSIBcDTEblTTqYVUTo0RKLjTFh6imFb4
	 hZ8wuNEitG5VueBrE+X7f0HOR2amHg1enNENxyzGBjWKQz3cIzGA9pvr8VA2X/0NAi
	 6kTKrY4asCTV8rSjIOrOi8OgC+KWvH9GiHCAFXM7oXnbMzPcqpp7cwTnDp01Aaitgu
	 BrAqYzn9bnjkA==
Date: Thu, 30 Jul 2026 12:01:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
Message-ID: <amsg_zNrBzViGEBr@ryzen>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <ampndLtU32ODmncX@ryzen>
 <nvpa2qlo7rbhmeuk3ijf2pzsqp43o4hnexafk3ep3gho3w27sk@lbpqgyaelqxc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvpa2qlo7rbhmeuk3ijf2pzsqp43o4hnexafk3ep3gho3w27sk@lbpqgyaelqxc>

On Thu, Jul 30, 2026 at 06:32:08AM +0200, Manivannan Sadhasivam wrote:
> > 
> > Ignore that the test case leaves things to be desired, since it passes even
> > though we see this warning.
> > 
> 
> How come this is possible? Doorbell timeout occured, but still Doorbell got
> triggered in EP?

The doorbell is triggered. It is just that the if statement:

if (!left || (status & STATUS_DOORBELL_ENABLE_FAIL)) {

is really bad...

A better way would be to check

if (!left || !(status & STATUS_DOORBELL_ENABLE_SUCCESS)) {


The problem seems to be that we re-read status, and the second time we
read the status, the STATUS_DOORBELL_SUCCESS bit is set.

I can send two patches for this.


> 
> > 
> > The problem seems to be that the embedded doorbell IRQ handler is executed twice,
> > in response to a single writel() which rings the doorbell.
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 4802d4f80f78..7f4360579ffb 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -714,6 +714,7 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> >  
> >         status |= STATUS_DOORBELL_SUCCESS;
> >         reg->status = cpu_to_le32(status);
> > +       trace_printk("calling pci_epf_test_raise_irq()\n");
> >         pci_epf_test_raise_irq(epf_test, reg);
> >  
> >         return IRQ_HANDLED;
> > 
> > 
> > As you can see:
> >  irq/58-pci-ep-t-221     [006] .....    58.601020: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
> >  irq/58-pci-ep-t-221     [006] .....    58.601421: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
> > 
> > It is called twice for a single doorbell ring.
> > 
> 
> Which doorbell is used here? Platform MSI or Embedded one?

Embedded.

I now see what is going on:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3635741c3e7a..b554f7c38ecc 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -176,8 +176,10 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)

        reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
        if (reg & STATUS_IRQ_RAISED) {
+               unsigned int old = READ_ONCE(test->irq_raised.done);
                test->last_irq = irq;
                complete(&test->irq_raised);
+               trace_printk("old: %u new: %u\n", old, READ_ONCE(test->irq_raised.done));
        }

        return IRQ_HANDLED;
@@ -1076,6 +1078,8 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
        u32 addr;
        int left;

+       trace_printk("enter\n");
+
        if (!(test->ep_caps & CAP_DYNAMIC_INBOUND_MAPPING))
                return -EOPNOTSUPP;

@@ -1093,11 +1097,14 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
        left = wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));

        status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+       trace_printk("after ENABLE DOORBELL wait, status: %u left: %d\n", status, left);
        if (!left || (status & STATUS_DOORBELL_ENABLE_FAIL)) {
                dev_err(dev, "Failed to enable doorbell\n");
                return -EINVAL;
        }

+       msleep(500);
+
        data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
        addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);

@@ -1113,12 +1120,13 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
                return -ERANGE;
        }

+       trace_printk("ringing doorbell\n");
        writel(data, test->bar[bar] + addr);

        left = wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));

        status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-
+       trace_printk("after RING DOORBELL wait, status: %u left: %d\n", status, left);
        if (!left || !(status & STATUS_DOORBELL_SUCCESS))
                dev_err(dev, "Failed to trigger doorbell in endpoint\n");



As you can see, even adding a msleep(500) between the
ENABLE_DOORBELL call

and the RING DOORBELL writel(), we still get two IRQs.

         pcitest-307     [002] .....    65.050035: pci_endpoint_test_ioctl: enter
          <idle>-0       [007] d.h1.    65.057615: pci_endpoint_test_irqhandler: old: 0 new: 1
          <idle>-0       [007] d.h1.    65.057626: pci_endpoint_test_irqhandler: old: 1 new: 2
         pcitest-307     [006] .....    65.057734: pci_endpoint_test_ioctl: after ENABLE DOORBELL wait, status: 1088 left: 248
         pcitest-307     [006] .....    65.585419: pci_endpoint_test_ioctl: ringing doorbell
         pcitest-307     [006] .....    65.585423: pci_endpoint_test_ioctl: after RING DOORBELL wait, status: 0 left: 250
          <idle>-0       [007] d.h1.    65.585682: pci_endpoint_test_irqhandler: old: 0 new: 1
          <idle>-0       [007] d.h1.    65.591753: pci_endpoint_test_irqhandler: old: 0 new: 1


As you can see, status is 1088, so bit 10 is set (STATUS_DOORBELL_ENABLE_SUCCESS).

And since this is before even writing the doorbell, what seems to happen is that
we get an IRQ when calling request_irq().

So it looks like we have uncleared hardware status flags, or possibly incorrect
edge/level trigger configurations.


Kind regards,
Niklas
